#!/bin/bash

echo "=== Docker Network Test Script ==="
echo "This script will help verify your Docker network setup"
echo ""

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running or not accessible"
    exit 1
fi

echo "✅ Docker is running"

# List all networks
echo ""
echo "=== Current Docker Networks ==="
docker network ls

# Check if dokploy-network exists
echo ""
echo "=== Checking for dokploy-network ==="
if docker network ls | grep -q "dokploy-network"; then
    echo "✅ dokploy-network exists"
    echo ""
    echo "=== dokploy-network details ==="
    docker network inspect dokploy-network
else
    echo "❌ dokploy-network not found"
    echo ""
    echo "=== Creating dokploy-network ==="
    docker network create dokploy-network
    echo "✅ dokploy-network created"
fi

# Check running containers
echo ""
echo "=== Running Containers ==="
docker ps

# Check if any containers are using dokploy-network
echo ""
echo "=== Containers using dokploy-network ==="
docker network inspect dokploy-network --format='{{range .Containers}}{{.Name}} {{end}}' 2>/dev/null || echo "No containers found"

echo ""
echo "=== Test Complete ==="
