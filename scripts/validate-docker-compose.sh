#!/usr/bin/env bash
# Validation script for docker-compose.yml YAML syntax
# This script validates YAML syntax and structure of all docker-compose files

set -uo pipefail

echo "🔍 Validating Docker Compose YAML Files"
echo "=========================================="
echo ""

# Counter for checks
PASSED=0
FAILED=0
WARNINGS=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check YAML syntax
check_yaml_syntax() {
    local file="$1"
    local service_name=$(basename $(dirname "$file"))
    
    # Check if Python and PyYAML are available
    if command -v python3 &>/dev/null; then
        if python3 -c "import yaml" &>/dev/null; then
            # Use Python to validate YAML syntax
            if python3 -c "import yaml; yaml.safe_load(open('$file'))" &>/dev/null 2>&1; then
                echo -e "${GREEN}✓${NC} $service_name: Valid YAML syntax"
                PASSED=$((PASSED + 1))
                return 0
            else
                echo -e "${RED}✗${NC} $service_name: Invalid YAML syntax"
                python3 -c "import yaml; yaml.safe_load(open('$file'))" 2>&1 | head -5
                FAILED=$((FAILED + 1))
                return 1
            fi
        fi
    fi
    
    # Fallback: Basic syntax check
    echo -e "${YELLOW}⚠${NC} $service_name: Python/PyYAML not available, skipping detailed validation"
    WARNINGS=$((WARNINGS + 1))
    return 0
}

# Function to check services indentation
check_services_indentation() {
    local file="$1"
    local service_name=$(basename $(dirname "$file"))
    
    # Check that line 2 (service name) is indented with 2 spaces
    local line2=$(sed -n '2p' "$file")
    
    # Check if line 2 starts with exactly 2 spaces followed by a word and colon
    if [[ "$line2" =~ ^[[:space:]]{2}[a-z][a-z0-9-]*:$ ]]; then
        echo -e "${GREEN}✓${NC} $service_name: Service name properly indented"
        PASSED=$((PASSED + 1))
        return 0
    elif [[ "$line2" =~ ^[a-z][a-z0-9-]*:$ ]]; then
        echo -e "${RED}✗${NC} $service_name: Service name NOT indented (should have 2 spaces)"
        FAILED=$((FAILED + 1))
        return 1
    else
        echo -e "${YELLOW}⚠${NC} $service_name: Unexpected format on line 2"
        WARNINGS=$((WARNINGS + 1))
        return 0
    fi
}

# Function to check services is a mapping
check_services_mapping() {
    local file="$1"
    local service_name=$(basename $(dirname "$file"))
    
    # Check that line 1 is "services:"
    local line1=$(sed -n '1p' "$file")
    
    if [[ "$line1" =~ ^services:[[:space:]]*$ ]]; then
        echo -e "${GREEN}✓${NC} $service_name: 'services:' key present"
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $service_name: Missing or malformed 'services:' key"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

echo "1. Checking YAML Syntax"
echo "----------------------"
for compose_file in services/*/docker-compose.yml; do
    if [ -f "$compose_file" ]; then
        check_yaml_syntax "$compose_file"
    fi
done

echo ""
echo "2. Checking 'services:' Key"
echo "-------------------------"
for compose_file in services/*/docker-compose.yml; do
    if [ -f "$compose_file" ]; then
        check_services_mapping "$compose_file"
    fi
done

echo ""
echo "3. Checking Service Name Indentation"
echo "-----------------------------------"
for compose_file in services/*/docker-compose.yml; do
    if [ -f "$compose_file" ]; then
        check_services_indentation "$compose_file"
    fi
done

echo ""
echo "=========================================="
echo "📊 Validation Results"
echo "=========================================="
echo -e "${GREEN}Passed:${NC} $PASSED"
echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
echo -e "${RED}Failed:${NC} $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ All validation checks passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ Some validation checks failed${NC}"
    echo ""
    echo "To fix indentation issues, ensure:"
    echo "  1. Line 1 is 'services:' with no indentation"
    echo "  2. Line 2 (service name) has exactly 2 spaces of indentation"
    echo "  3. Service properties have 4 spaces of indentation"
    exit 1
fi
