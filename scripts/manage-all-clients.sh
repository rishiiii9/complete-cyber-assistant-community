#!/bin/bash

# Script to manage all CISO Assistant client instances
# Usage: ./manage-all-clients.sh [command] [options]

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

# Default client list (update this as you add more clients)
CLIENTS=(
    "grc-client1:grc-client1.completecyber.uk"
    "grc-client2:grc-client2.completecyber.uk"
)

# Function to show usage
show_usage() {
    echo "Usage: $0 [command] [options]"
    echo
    echo "Commands:"
    echo "  health-check    - Check health of all client instances"
    echo "  create <name> <domain> - Create a new client instance"
    echo "  list           - List all configured clients"
    echo "  status         - Show status of all clients"
    echo "  backup         - Create backup of all client data"
    echo "  update         - Update all client instances"
    echo "  logs <client>  - Show logs for specific client"
    echo "  restart <client> - Restart specific client"
    echo
    echo "Examples:"
    echo "  $0 health-check"
    echo "  $0 create grc-client3 grc-client3.completecyber.uk"
    echo "  $0 status"
    echo "  $0 logs grc-client1"
}

# Function to check health of all clients
health_check_all() {
    print_status "Performing health check for all clients..."
    echo
    
    local all_healthy=true
    
    for client_info in "${CLIENTS[@]}"; do
        IFS=':' read -r client_name client_domain <<< "$client_info"
        
        print_status "Checking $client_name ($client_domain)..."
        
        # Check frontend
        if curl -f -s -o /dev/null --connect-timeout 10 "https://$client_domain"; then
            echo "  ✅ Frontend: OK"
        else
            echo "  ❌ Frontend: FAILED"
            all_healthy=false
        fi
        
        # Check backend API
        if curl -f -s -o /dev/null --connect-timeout 10 "https://$client_domain/api/"; then
            echo "  ✅ Backend API: OK"
        else
            echo "  ❌ Backend API: FAILED"
            all_healthy=false
        fi
        
        # Check SSL certificate
        if openssl s_client -connect "$client_domain:443" -servername "$client_domain" < /dev/null 2>/dev/null | openssl x509 -noout -dates | grep -q "notAfter"; then
            echo "  ✅ SSL Certificate: OK"
        else
            echo "  ❌ SSL Certificate: FAILED"
            all_healthy=false
        fi
        
        echo
    done
    
    if [ "$all_healthy" = true ]; then
        print_success "All clients are healthy!"
    else
        print_warning "Some clients have issues. Check individual client logs."
    fi
}

# Function to create a new client
create_client() {
    if [ $# -ne 2 ]; then
        print_error "Usage: $0 create <client-name> <client-domain>"
        exit 1
    fi
    
    local client_name=$1
    local client_domain=$2
    
    print_status "Creating new client: $client_name ($client_domain)"
    
    # Run the create-client-instance script
    if [ -f "scripts/create-client-instance.sh" ]; then
        ./scripts/create-client-instance.sh "$client_name" "$client_domain"
        
        # Add to clients list
        echo "grc-client$client_name:$client_domain" >> "scripts/client-list.txt"
        print_success "Client $client_name added to client list"
    else
        print_error "create-client-instance.sh script not found"
        exit 1
    fi
}

# Function to list all clients
list_clients() {
    print_status "Configured clients:"
    echo
    
    for i in "${!CLIENTS[@]}"; do
        IFS=':' read -r client_name client_domain <<< "${CLIENTS[$i]}"
        echo "  $((i+1)). $client_name"
        echo "     Domain: $client_domain"
        echo "     URL: https://$client_domain"
        echo
    done
}

# Function to show status of all clients
show_status() {
    print_status "Status of all clients:"
    echo
    
    for client_info in "${CLIENTS[@]}"; do
        IFS=':' read -r client_name client_domain <<< "$client_info"
        
        print_status "$client_name ($client_domain):"
        
        # Quick connectivity check
        if curl -f -s -o /dev/null --connect-timeout 5 "https://$client_domain"; then
            echo "  Status: 🟢 Online"
        else
            echo "  Status: 🔴 Offline"
        fi
        
        # Check response time
        response_time=$(curl -w "%{time_total}" -s -o /dev/null "https://$client_domain" 2>/dev/null || echo "N/A")
        echo "  Response Time: ${response_time}s"
        
        echo
    done
}

# Function to create backup
create_backup() {
    print_status "Creating backup of all client data..."
    
    local backup_dir="backups/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    for client_info in "${CLIENTS[@]}"; do
        IFS=':' read -r client_name client_domain <<< "$client_info"
        
        print_status "Backing up $client_name..."
        
        # Create client backup directory
        mkdir -p "$backup_dir/$client_name"
        
        # Backup compose file
        if [ -f "docker-compose-$client_name.yml" ]; then
            cp "docker-compose-$client_name.yml" "$backup_dir/$client_name/"
        fi
        
        # Backup environment file
        if [ -f "env-$client_name.txt" ]; then
            cp "env-$client_name.txt" "$backup_dir/$client_name/"
        fi
        
        # Backup deployment checklist
        if [ -f "deployment-checklist-$client_name.md" ]; then
            cp "deployment-checklist-$client_name.md" "$backup_dir/$client_name/"
        fi
        
        print_success "Backed up $client_name"
    done
    
    print_success "Backup completed: $backup_dir"
}

# Function to update all clients
update_all_clients() {
    print_warning "This will trigger updates for all client instances in Dokploy"
    read -p "Are you sure you want to continue? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Updating all client instances..."
        
        for client_info in "${CLIENTS[@]}"; do
            IFS=':' read -r client_name client_domain <<< "$client_info"
            
            print_status "Updating $client_name..."
            echo "  - Go to Dokploy dashboard"
            echo "  - Find app for $client_domain"
            echo "  - Click 'Redeploy' or 'Update'"
            echo "  - Monitor deployment logs"
            echo
        done
        
        print_success "Update instructions provided for all clients"
    else
        print_status "Update cancelled"
    fi
}

# Function to show logs for specific client
show_logs() {
    if [ $# -ne 1 ]; then
        print_error "Usage: $0 logs <client-name>"
        exit 1
    fi
    
    local client_name=$1
    local client_domain=""
    
    # Find client domain
    for client_info in "${CLIENTS[@]}"; do
        IFS=':' read -r name domain <<< "$client_info"
        if [ "$name" = "$client_name" ]; then
            client_domain=$domain
            break
        fi
    done
    
    if [ -z "$client_domain" ]; then
        print_error "Client $client_name not found"
        exit 1
    fi
    
    print_status "Logs for $client_name ($client_domain):"
    echo
    echo "To view logs:"
    echo "  1. Go to Dokploy dashboard"
    echo "  2. Find app for $client_domain"
    echo "  3. Click on 'Logs' tab"
    echo "  4. Select service (backend, frontend, huey)"
    echo
    echo "Or use health check script:"
    echo "  ./health-check-$client_name.sh"
}

# Function to restart specific client
restart_client() {
    if [ $# -ne 1 ]; then
        print_error "Usage: $0 restart <client-name>"
        exit 1
    fi
    
    local client_name=$1
    local client_domain=""
    
    # Find client domain
    for client_info in "${CLIENTS[@]}"; do
        IFS=':' read -r name domain <<< "$client_info"
        if [ "$name" = "$client_name" ]; then
            client_domain=$domain
            break
        fi
    done
    
    if [ -z "$client_domain" ]; then
        print_error "Client $client_name not found"
        exit 1
    fi
    
    print_status "Restarting $client_name ($client_domain):"
    echo
    echo "To restart:"
    echo "  1. Go to Dokploy dashboard"
    echo "  2. Find app for $client_domain"
    echo "  3. Click 'Restart' or 'Redeploy'"
    echo "  4. Monitor restart process"
    echo
    echo "Or use health check after restart:"
    echo "  ./health-check-$client_name.sh"
}

# Main script logic
case "${1:-}" in
    "health-check")
        health_check_all
        ;;
    "create")
        create_client "$2" "$3"
        ;;
    "list")
        list_clients
        ;;
    "status")
        show_status
        ;;
    "backup")
        create_backup
        ;;
    "update")
        update_all_clients
        ;;
    "logs")
        show_logs "$2"
        ;;
    "restart")
        restart_client "$2"
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
