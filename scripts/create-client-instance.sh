#!/bin/bash

# Script to create a new client instance for CISO Assistant
# Usage: ./create-client-instance.sh <client-name> <client-domain>

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required arguments are provided
if [ $# -ne 2 ]; then
    print_error "Usage: $0 <client-name> <client-domain>"
    print_error "Example: $0 grc-client3 grc-client3.completecyber.uk"
    exit 1
fi

CLIENT_NAME=$1
CLIENT_DOMAIN=$2

# Validate client name format
if [[ ! $CLIENT_NAME =~ ^[a-z0-9-]+$ ]]; then
    print_error "Client name must contain only lowercase letters, numbers, and hyphens"
    exit 1
fi

# Validate domain format
if [[ ! $CLIENT_DOMAIN =~ ^[a-z0-9.-]+\.[a-z]{2,}$ ]]; then
    print_error "Invalid domain format"
    exit 1
fi

print_status "Creating client instance: $CLIENT_NAME ($CLIENT_DOMAIN)"

# Generate secure passwords
DB_PASSWORD=$(openssl rand -base64 32 | tr -d "=+/" | cut -c1-25)
ADMIN_PASSWORD=$(openssl rand -base64 32 | tr -d "=+/" | cut -c1-25)

print_status "Generated secure passwords for database and admin user"

# Create compose file from template
COMPOSE_FILE="docker-compose-${CLIENT_NAME}.yml"

if [ -f "$COMPOSE_FILE" ]; then
    print_warning "Compose file $COMPOSE_FILE already exists. Overwriting..."
fi

print_status "Creating compose file: $COMPOSE_FILE"

# Copy template and replace placeholders
cp docker-compose-client-template.yml "$COMPOSE_FILE"

# Replace placeholders in the compose file
sed -i.bak "s/CLIENT_NAME/$CLIENT_NAME/g" "$COMPOSE_FILE"
sed -i.bak "s/CLIENT_DOMAIN/$CLIENT_DOMAIN/g" "$COMPOSE_FILE"

# Remove backup file
rm "${COMPOSE_FILE}.bak"

print_success "Created compose file: $COMPOSE_FILE"

# Create environment variables file for Dokploy
ENV_FILE="env-${CLIENT_NAME}.txt"

cat > "$ENV_FILE" << EOF
# Environment Variables for $CLIENT_NAME ($CLIENT_DOMAIN)
# Copy these to Dokploy dashboard

# Backend Environment Variables
DJANGO_SETTINGS_MODULE=ciso_assistant.settings
DJANGO_DEBUG=False
ALLOWED_HOSTS=$CLIENT_DOMAIN,*.dokploy.com
CISO_ASSISTANT_URL=https://$CLIENT_DOMAIN
POSTGRES_NAME=ciso_assistant_$CLIENT_NAME
POSTGRES_USER=ciso_assistant_$CLIENT_NAME
POSTGRES_PASSWORD=$DB_PASSWORD
DB_HOST=db
DB_PORT=5432
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_HOST_USER=ejones@completecyber.uk
EMAIL_HOST_PASSWORD=vwrahbxebhmrzidy
EMAIL_USE_TLS=True
DEFAULT_FROM_EMAIL=ejones@completecyber.uk
DJANGO_SUPERUSER_EMAIL=admin@$CLIENT_DOMAIN
DJANGO_SUPERUSER_PASSWORD=$ADMIN_PASSWORD

# Frontend Environment Variables
NODE_ENV=production
PUBLIC_BACKEND_API_URL=http://backend:8000/api
PORT=3000
HOST=0.0.0.0
EOF

print_success "Created environment variables file: $ENV_FILE"

# Create deployment checklist
CHECKLIST_FILE="deployment-checklist-${CLIENT_NAME}.md"

cat > "$CHECKLIST_FILE" << EOF
# Deployment Checklist for $CLIENT_NAME

## DNS Configuration
- [ ] Add A record: $CLIENT_DOMAIN → YOUR_DOKPLOY_SERVER_IP
- [ ] Verify DNS propagation: \`nslookup $CLIENT_DOMAIN\`

## Dokploy Setup
- [ ] Create new Compose App in Dokploy
- [ ] Repository: rishiiii9/complete-cyber-assistant-community
- [ ] Branch: main
- [ ] Compose file: $COMPOSE_FILE
- [ ] Copy environment variables from $ENV_FILE
- [ ] Set custom domain: $CLIENT_DOMAIN
- [ ] Enable SSL certificate
- [ ] Configure resource allocation (1 vCPU, 2GB RAM, 10GB Storage)

## Deployment
- [ ] Deploy application
- [ ] Monitor deployment logs
- [ ] Verify services are healthy
- [ ] Test frontend: https://$CLIENT_DOMAIN
- [ ] Test backend API: https://$CLIENT_DOMAIN/api/
- [ ] Login with admin credentials

## Post-Deployment
- [ ] Update DNS if needed
- [ ] Test email functionality
- [ ] Verify SSL certificate
- [ ] Create client-specific documentation
- [ ] Add to monitoring dashboard

## Admin Credentials
- Email: admin@$CLIENT_DOMAIN
- Password: $ADMIN_PASSWORD

## Database Credentials
- Database: ciso_assistant_$CLIENT_NAME
- User: ciso_assistant_$CLIENT_NAME
- Password: $DB_PASSWORD
EOF

print_success "Created deployment checklist: $CHECKLIST_FILE"

# Create health check script
HEALTH_SCRIPT="health-check-${CLIENT_NAME}.sh"

cat > "$HEALTH_SCRIPT" << 'EOF'
#!/bin/bash

CLIENT_DOMAIN="$CLIENT_DOMAIN"
CLIENT_NAME="$CLIENT_NAME"

echo "Health check for $CLIENT_NAME ($CLIENT_DOMAIN)"

# Check frontend
echo "Checking frontend..."
if curl -f -s -o /dev/null "https://$CLIENT_DOMAIN"; then
    echo "✅ Frontend is accessible"
else
    echo "❌ Frontend is not accessible"
fi

# Check backend API
echo "Checking backend API..."
if curl -f -s -o /dev/null "https://$CLIENT_DOMAIN/api/"; then
    echo "✅ Backend API is accessible"
else
    echo "❌ Backend API is not accessible"
fi

# Check SSL certificate
echo "Checking SSL certificate..."
if openssl s_client -connect "$CLIENT_DOMAIN:443" -servername "$CLIENT_DOMAIN" < /dev/null 2>/dev/null | openssl x509 -noout -dates | grep -q "notAfter"; then
    echo "✅ SSL certificate is valid"
else
    echo "❌ SSL certificate issue detected"
fi

echo "Health check completed for $CLIENT_NAME"
EOF

chmod +x "$HEALTH_SCRIPT"
print_success "Created health check script: $HEALTH_SCRIPT"

# Summary
echo
print_success "Client instance setup completed!"
echo
echo "Files created:"
echo "  📄 $COMPOSE_FILE - Docker Compose configuration"
echo "  📄 $ENV_FILE - Environment variables for Dokploy"
echo "  📄 $CHECKLIST_FILE - Deployment checklist"
echo "  📄 $HEALTH_SCRIPT - Health check script"
echo
echo "Next steps:"
echo "  1. Add DNS record for $CLIENT_DOMAIN"
echo "  2. Create new Dokploy app using $COMPOSE_FILE"
echo "  3. Copy environment variables from $ENV_FILE"
echo "  4. Follow the deployment checklist in $CHECKLIST_FILE"
echo
echo "Admin credentials:"
echo "  Email: admin@$CLIENT_DOMAIN"
echo "  Password: $ADMIN_PASSWORD"
echo
print_warning "Remember to save the passwords securely!"
