#!/bin/bash
# Validation script for home lab setup

set -e

echo "============================================"
echo "Home Lab Setup Validation"
echo "============================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

success_count=0
warning_count=0
error_count=0

check_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((success_count++))
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((warning_count++))
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
    ((error_count++))
}

echo "1. Checking required files..."

# Check essential files exist
files=("docker-compose.yml" ".env.example" "justfile" "README.md" "mkdocs.yml" "PROJECT_PLAN.md")
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        check_pass "$file exists"
    else
        check_fail "$file missing"
    fi
done

echo ""
echo "2. Checking directory structure..."

# Check directories exist
dirs=("docs" "config" "scripts" "docs/getting-started" "docs/services" "docs/operations" "docs/reference")
for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        check_pass "$dir/ exists"
    else
        check_fail "$dir/ missing"
    fi
done

echo ""
echo "3. Checking docker-compose.yml..."

# Validate docker-compose
if command -v docker &> /dev/null; then
    if docker compose config > /dev/null 2>&1; then
        check_pass "docker-compose.yml is valid"
    else
        check_fail "docker-compose.yml has errors"
    fi
else
    check_warn "Docker not installed, skipping docker-compose validation"
fi

# Count services in docker-compose.yml
if [ -f "docker-compose.yml" ]; then
    service_count=$(grep -c "container_name:" docker-compose.yml || echo 0)
    if [ "$service_count" -eq 31 ]; then
        check_pass "Correct number of services: 31 (30 main + MkDocs)"
    else
        check_warn "Expected 31 services (30 main + MkDocs), found $service_count"
    fi
fi

echo ""
echo "4. Checking documentation files..."

# Check key documentation files
doc_files=(
    "docs/index.md"
    "docs/getting-started/quick-start.md"
    "docs/getting-started/installation.md"
    "docs/getting-started/configuration.md"
    "docs/operations/backup-restore.md"
    "docs/operations/troubleshooting.md"
    "docs/reference/commands.md"
    "docs/reference/faq.md"
    "docs/services/media.md"
    "docs/services/music.md"
    "docs/services/books.md"
    "docs/services/monitoring.md"
)

for doc in "${doc_files[@]}"; do
    if [ -f "$doc" ]; then
        check_pass "$doc exists"
    else
        check_warn "$doc missing"
    fi
done

echo ""
echo "5. Checking configuration files..."

# Check config files
config_files=(
    "config/prometheus/prometheus.yml"
    "config/loki/local-config.yaml"
    "scripts/init-databases.sql"
)

for config in "${config_files[@]}"; do
    if [ -f "$config" ]; then
        check_pass "$config exists"
    else
        check_warn "$config missing"
    fi
done

echo ""
echo "6. Checking justfile syntax..."

if [ -f "justfile" ]; then
    # Check for common justfile patterns
    if grep -q "services action=" justfile; then
        check_pass "justfile contains service management commands"
    else
        check_fail "justfile missing service management commands"
    fi
    
    if grep -q "backup target=" justfile; then
        check_pass "justfile contains backup commands"
    else
        check_fail "justfile missing backup commands"
    fi
    
    if grep -q "monitor target=" justfile; then
        check_pass "justfile contains monitoring commands"
    else
        check_fail "justfile missing monitoring commands"
    fi
fi

echo ""
echo "7. Checking for removed services..."

# Ensure removed services are not in docker-compose.yml
removed_services=("gitea" "node-red" "vaultwarden")
for service in "${removed_services[@]}"; do
    if grep -qi "$service" docker-compose.yml; then
        check_fail "Found removed service: $service"
    else
        check_pass "$service correctly removed"
    fi
done

echo ""
echo "8. Checking for documentation service..."

if grep -q "mkdocs" docker-compose.yml; then
    check_pass "MkDocs documentation service present"
else
    check_fail "MkDocs documentation service missing"
fi

echo ""
echo "============================================"
echo "Validation Summary"
echo "============================================"
echo -e "${GREEN}Passed: $success_count${NC}"
echo -e "${YELLOW}Warnings: $warning_count${NC}"
echo -e "${RED}Failed: $error_count${NC}"
echo ""

if [ $error_count -eq 0 ]; then
    echo -e "${GREEN}✓ Validation completed successfully!${NC}"
    exit 0
else
    echo -e "${RED}✗ Validation failed with $error_count error(s)${NC}"
    exit 1
fi
