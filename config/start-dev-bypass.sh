#!/bin/bash

# Development Startup Script with Authentication Bypass
# This script starts CISO Assistant with authentication disabled for local development

echo "🚀 Starting CISO Assistant with Authentication Bypass..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Stop any existing containers
echo "🛑 Stopping existing containers..."
docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml down

# Start services with override
echo "🔓 Starting services with authentication bypass..."
docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml up -d

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check service status
echo "📊 Service Status:"
docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml ps

echo ""
echo "✅ CISO Assistant is starting up!"
echo "🌐 Frontend: http://localhost:3000 (Authentication bypassed)"
echo "🔧 Backend API: http://localhost:8000/api"
echo ""
echo "📝 To view logs: docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml logs -f"
echo "🛑 To stop: docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml down"
