#!/usr/bin/env bash
# Manage and fix environment variables for services
# Usage:
#   ./scripts/vars.sh check <service>  - Report missing/empty vars
#   ./scripts/vars.sh fix <service>    - Auto-populate missing/empty vars in .env

set -euo pipefail

ACTION="${1:?Action required: check or fix}"
SERVICE_NAME="${2:?Service name required}"
SERVICE_DIR="services/$SERVICE_NAME"
COMPOSE_FILE="$SERVICE_DIR/docker-compose.yml"
ENV_FILE=".env"
ENV_EXAMPLE=".env.example"

# Helper function to generate secure random values
generate_password() {
    openssl rand -base64 32 | tr -d '=' | cut -c1-32
}

# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
    if [ "$ACTION" = "check" ]; then
        echo "ERROR: .env file not found"
        echo "Please run: cp .env.example .env && just password"
        exit 1
    else
        # For fix, create .env from example
        cp "$ENV_EXAMPLE" "$ENV_FILE"
        echo "Created .env from .env.example"
    fi
fi

# Check if service directory exists
if [ ! -d "$SERVICE_DIR" ]; then
    echo "ERROR: Service directory $SERVICE_DIR not found"
    exit 1
fi

# Check if docker-compose.yml exists
if [ ! -f "$COMPOSE_FILE" ]; then
    echo "ERROR: docker-compose.yml not found for service $SERVICE_NAME"
    exit 1
fi

# Extract all environment variables referenced in docker-compose.yml
referenced_vars=$(grep -oE '\$\{[A-Z_]+[:-]?' "$COMPOSE_FILE" | sed 's/\${//g' | sed 's/[:-].*//g' | sort -u)

if [ -z "$referenced_vars" ]; then
    if [ "$ACTION" = "check" ]; then
        echo "✓ Service '$SERVICE_NAME' has no environment variables to configure"
    fi
    exit 0
fi

# Separate missing and empty vars
missing_vars=()
empty_vars=()

while IFS= read -r var; do
    if [ -z "$var" ]; then
        continue
    fi
    
    # Check if variable is defined in .env
    if ! grep -q "^${var}=" "$ENV_FILE"; then
        missing_vars+=("$var")
    else
        # Check if variable is empty
        value=$(grep "^${var}=" "$ENV_FILE" | cut -d'=' -f2- | head -1)
        if [ -z "$value" ]; then
            empty_vars+=("$var")
        fi
    fi
done <<< "$referenced_vars"

# Handle check action
if [ "$ACTION" = "check" ]; then
    if [ ${#missing_vars[@]} -eq 0 ] && [ ${#empty_vars[@]} -eq 0 ]; then
        echo "✓ Service '$SERVICE_NAME' has all environment variables configured"
        exit 0
    fi
    
    echo "⚠ Service '$SERVICE_NAME' has missing or empty environment variables:"
    if [ ${#missing_vars[@]} -gt 0 ]; then
        echo ""
        echo "Missing from .env:"
        for var in "${missing_vars[@]}"; do
            echo "  - $var"
        done
    fi
    if [ ${#empty_vars[@]} -gt 0 ]; then
        echo ""
        echo "Empty values in .env:"
        for var in "${empty_vars[@]}"; do
            echo "  - $var"
        done
    fi
    echo ""
    echo "Run 'just vars $SERVICE_NAME fix' to auto-populate these values"
    exit 1
fi

# Handle fix action
if [ "$ACTION" = "fix" ]; then
    echo "Fixing environment variables for service '$SERVICE_NAME'..."
    
    # Check if header already exists in .env for this service
    service_prefix=$(echo "$SERVICE_NAME" | tr '[:lower:]' '[:upper:]')
    header_exists=false
    if grep -q "# ${service_prefix} -" "$ENV_FILE"; then
        header_exists=true
    fi
    
    # If we have missing vars and no header, extract and add header from .env.example
    if [ ${#missing_vars[@]} -gt 0 ] && [ "$header_exists" = false ]; then
        # Extract full header section from .env.example (3 lines: separator, title, separator)
        header_line=$(grep -n "^# ${service_prefix} -" "$ENV_EXAMPLE" | cut -d: -f1)
        if [ -n "$header_line" ]; then
            # Get the 3-line header block (previous line, current line, next line)
            start_line=$((header_line - 1))
            if [ "$start_line" -lt 1 ]; then
                start_line=1
            fi
            end_line=$((header_line + 1))
            header=$(sed -n "${start_line},${end_line}p" "$ENV_EXAMPLE")
            
            if [ -n "$header" ]; then
                # Add blank line before header for readability, then the header
                echo "" >> "$ENV_FILE"
                echo "$header" >> "$ENV_FILE"
            fi
        fi
    fi
    
    # Process missing variables
    for var in "${missing_vars[@]}"; do
        # Determine value based on variable pattern
        if [[ "$var" =~ PASSWORD|SECRET|KEY ]] && [[ "$var" != "PORT" ]]; then
            # Generate secure password for password/secret/key vars
            value=$(generate_password)
        elif [[ "$var" =~ PORT ]]; then
            # Skip PORT vars, they should be manually set
            value=""
        elif [[ "$var" =~ UID|GID ]]; then
            # Default to 1000 for UID/GID
            value="1000"
        else
            # Try to find default from .env.example
            if grep -q "^${var}=" "$ENV_EXAMPLE"; then
                value=$(grep "^${var}=" "$ENV_EXAMPLE" | cut -d'=' -f2- | head -1)
            else
                value=""
            fi
        fi
        
        # Add variable to .env
        echo "${var}=${value}" >> "$ENV_FILE"
        if [ -z "$value" ]; then
            echo "  + $var = (empty - needs manual configuration)"
        else
            echo "  + $var = ***"
        fi
    done
    
    # Process empty variables
    for var in "${empty_vars[@]}"; do
        # Determine value based on variable pattern
        if [[ "$var" =~ PASSWORD|SECRET|KEY ]] && [[ "$var" != "PORT" ]]; then
            # Generate secure password for password/secret/key vars
            value=$(generate_password)
        elif [[ "$var" =~ PORT ]]; then
            # Skip PORT vars
            value=""
        elif [[ "$var" =~ UID|GID ]]; then
            # Default to 1000 for UID/GID
            value="1000"
        else
            # Try to find default from .env.example
            if grep -q "^${var}=" "$ENV_EXAMPLE"; then
                example_value=$(grep "^${var}=" "$ENV_EXAMPLE" | cut -d'=' -f2- | head -1)
                value="${example_value}"
            else
                value=""
            fi
        fi
        
        # Replace empty variable in .env
        if [ -n "$value" ]; then
            # Use @ as delimiter to handle / in values
            sed -i '' "s@^${var}=@${var}=${value}@" "$ENV_FILE"
            echo "  ~ $var = ***"
        else
            echo "  ~ $var = (still empty - needs manual configuration)"
        fi
    done
    
    echo ""
    echo "✓ Fixed environment variables for '$SERVICE_NAME'"
    echo "Review .env for any manually-empty values that need configuration"
    exit 0
fi

echo "ERROR: Unknown action '$ACTION'. Use 'check' or 'fix'"
exit 1
