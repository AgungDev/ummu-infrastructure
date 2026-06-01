#!/bin/bash

# UMMU Infrastructure Health Check Script

echo "🔍 UMMU Infrastructure Health Check"
echo "===================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_service() {
    local name=$1
    local url=$2
    
    if curl -s "$url" > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $name"
        return 0
    else
        echo -e "${RED}✗${NC} $name"
        return 1
    fi
}

echo "Checking Services..."
echo ""

check_service "Kong Admin API" "http://localhost:8001/status"
check_service "Kong Proxy" "http://localhost:8000"
check_service "Auth Service" "http://localhost:3001/health"
check_service "Jaeger UI" "http://localhost:16686/"
check_service "Prometheus" "http://localhost:9090/-/healthy"
check_service "Grafana" "http://localhost:3000/api/health"

echo ""
echo "===================================="
echo ""

# Docker Compose Status
echo "Docker Compose Services:"
echo ""
docker-compose ps

echo ""
echo "===================================="
echo ""
echo "📊 Dashboard URLs:"
echo ""
echo "  Kong Admin:    http://localhost:8001"
echo "  Jaeger:        http://localhost:16686"
echo "  Prometheus:    http://localhost:9090"
echo "  Grafana:       http://localhost:3000 (admin/admin)"
echo ""
echo "===================================="
