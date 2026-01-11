#!/usr/bin/env bash
# Validation script for the modular service architecture

set -uo pipefail

echo "🔍 Validating Modular Service Architecture"
echo "=========================================="
echo ""

# Counter for checks
PASSED=0
FAILED=0

# Function to check and report
check() {
    local description="$1"
    local command="$2"
    
    echo -n "Checking $description... "
    if eval "$command" &>/dev/null; then
        echo "✓ PASSED"
        PASSED=$((PASSED + 1))
    else
        echo "✗ FAILED"
        FAILED=$((FAILED + 1))
    fi
}

# 1. Check if services directory exists
check "services/ directory exists" "[ -d services ]"

# 2. Count services
SERVICE_COUNT=$(find services -maxdepth 1 -type d | tail -n +2 | wc -l)
echo "Found $SERVICE_COUNT services"
check "31 services present" "[ $SERVICE_COUNT -eq 31 ]"

# 3. Check critical services have docker-compose.yml
for service in jellyfin postgres redis grafana prometheus; do
    check "$service has docker-compose.yml" "[ -f services/$service/docker-compose.yml ]"
    check "$service has README.md" "[ -f services/$service/README.md ]"
done

# 4. Check justfile exists
check "justfile exists" "[ -f justfile ]"

# 5. Check justfile syntax
check "justfile has valid bash syntax" "bash -n justfile"

# 6. Check network setup
check "network-setup.yml exists" "[ -f services/network-setup.yml ]"

# 7. Check backup preservation
check "old docker-compose preserved" "[ -f docker-compose.yml.monolithic ]"

# 8. Check config directories
check "config/ directory exists" "[ -d config ]"
check "scripts/ directory exists" "[ -d scripts ]"

# 9. Check documentation
check "modular-services.md exists" "[ -f docs/architecture/modular-services.md ]"
check "mkdocs.yml updated" "grep -q 'architecture/modular-services.md' mkdocs.yml"

# 10. Verify volume paths are updated
echo ""
echo "Checking volume path updates..."
if grep -r "^\s*-\s*\./" services/*/docker-compose.yml | grep -v "\.\./" | grep -v ":/docs" &>/dev/null; then
    echo "✗ FAILED - Some services still have incorrect relative paths"
    FAILED=$((FAILED + 1))
else
    echo "✓ PASSED - All volume paths correctly updated"
    PASSED=$((PASSED + 1))
fi

# 11. Check that services reference external homelab network
NETWORK_COUNT=$(grep -r "external: true" services/*/docker-compose.yml | wc -l)
check "services use external homelab network" "[ $NETWORK_COUNT -eq 31 ]"

echo ""
echo "=========================================="
echo "📊 Validation Results"
echo "=========================================="
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo "✅ All validation checks passed!"
    exit 0
else
    echo "❌ Some validation checks failed"
    exit 1
fi
