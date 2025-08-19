# Multi-Instance Dokploy Setup Guide

This guide provides step-by-step instructions for deploying multiple CISO Assistant instances on Dokploy, each with its own isolated environment and domain.

## Overview

**Approach:** Create separate Dokploy applications for each client instance
**Benefits:**
- Complete isolation between clients
- Independent deployments and updates
- Different resource allocations per client
- Separate monitoring and logging
- Individual scaling capabilities

## Prerequisites

- ✅ Dokploy account with sufficient resources
- ✅ GitHub repository with your code
- ✅ Docker images pushed to GitHub Container Registry
- ✅ Domain management access for subdomains

## Step 1: DNS Configuration

### 1.1 Configure Subdomains

Set up DNS records for each client instance:

```bash
# For grc-client1.completecyber.uk
grc-client1.completecyber.uk  A  YOUR_DOKPLOY_SERVER_IP

# For grc-client2.completecyber.uk  
grc-client2.completecyber.uk  A  YOUR_DOKPLOY_SERVER_IP

# For additional clients
grc-client3.completecyber.uk  A  YOUR_DOKPLOY_SERVER_IP
grc-client4.completecyber.uk  A  YOUR_DOKPLOY_SERVER_IP
```

### 1.2 Verify DNS Propagation

```bash
# Check DNS resolution
nslookup grc-client1.completecyber.uk
nslookup grc-client2.completecyber.uk
```

## Step 2: Create Dokploy Applications

### 2.1 Application 1: GRC Client 1

**Dokploy Dashboard Setup:**

1. **Login to Dokploy** dashboard
2. **Click "New App"** → **"Compose App"**
3. **Configure Repository:**
   - Repository: `rishiiii9/complete-cyber-assistant-community`
   - Branch: `main`
   - Compose file path: `docker-compose-grc-client1.yml`

4. **Set Environment Variables:**

**Backend Environment Variables:**
```
DJANGO_SETTINGS_MODULE=ciso_assistant.settings
DJANGO_DEBUG=False
ALLOWED_HOSTS=grc-client1.completecyber.uk,*.dokploy.com
CISO_ASSISTANT_URL=https://grc-client1.completecyber.uk
POSTGRES_NAME=ciso_assistant_client1
POSTGRES_USER=ciso_assistant_client1
POSTGRES_PASSWORD=ciso_assistant_client1_secure_password
DB_HOST=db
DB_PORT=5432
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_HOST_USER=ejones@completecyber.uk
EMAIL_HOST_PASSWORD=vwrahbxebhmrzidy
EMAIL_USE_TLS=True
DEFAULT_FROM_EMAIL=ejones@completecyber.uk
DJANGO_SUPERUSER_EMAIL=admin@grc-client1.completecyber.uk
DJANGO_SUPERUSER_PASSWORD=admin_client1_secure_password
```

**Frontend Environment Variables:**
```
NODE_ENV=production
PUBLIC_BACKEND_API_URL=http://backend:8000/api
PORT=3000
HOST=0.0.0.0
```

5. **Configure Custom Domain:**
   - Domain: `grc-client1.completecyber.uk`
   - Enable SSL certificate

6. **Resource Allocation:**
   - CPU: 1 vCPU
   - Memory: 2GB RAM
   - Storage: 10GB

### 2.2 Application 2: GRC Client 2

**Dokploy Dashboard Setup:**

1. **Click "New App"** → **"Compose App"**
2. **Configure Repository:**
   - Repository: `rishiiii9/complete-cyber-assistant-community`
   - Branch: `main`
   - Compose file path: `docker-compose-grc-client2.yml`

3. **Set Environment Variables:**

**Backend Environment Variables:**
```
DJANGO_SETTINGS_MODULE=ciso_assistant.settings
DJANGO_DEBUG=False
ALLOWED_HOSTS=grc-client2.completecyber.uk,*.dokploy.com
CISO_ASSISTANT_URL=https://grc-client2.completecyber.uk
POSTGRES_NAME=ciso_assistant_client2
POSTGRES_USER=ciso_assistant_client2
POSTGRES_PASSWORD=ciso_assistant_client2_secure_password
DB_HOST=db
DB_PORT=5432
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_HOST_USER=ejones@completecyber.uk
EMAIL_HOST_PASSWORD=vwrahbxebhmrzidy
EMAIL_USE_TLS=True
DEFAULT_FROM_EMAIL=ejones@completecyber.uk
DJANGO_SUPERUSER_EMAIL=admin@grc-client2.completecyber.uk
DJANGO_SUPERUSER_PASSWORD=admin_client2_secure_password
```

**Frontend Environment Variables:**
```
NODE_ENV=production
PUBLIC_BACKEND_API_URL=http://backend:8000/api
PORT=3000
HOST=0.0.0.0
```

4. **Configure Custom Domain:**
   - Domain: `grc-client2.completecyber.uk`
   - Enable SSL certificate

5. **Resource Allocation:**
   - CPU: 1 vCPU
   - Memory: 2GB RAM
   - Storage: 10GB

## Step 3: Deploy Applications

### 3.1 Deploy Client 1

1. **Review configuration** in Dokploy dashboard
2. **Click "Deploy"** for GRC Client 1
3. **Monitor deployment logs**
4. **Verify services are healthy**

### 3.2 Deploy Client 2

1. **Click "Deploy"** for GRC Client 2
2. **Monitor deployment logs**
3. **Verify services are healthy**

### 3.3 Verify Deployments

**Test Client 1:**
```bash
# Test frontend
curl -I https://grc-client1.completecyber.uk

# Test backend API
curl https://grc-client1.completecyber.uk/api/
```

**Test Client 2:**
```bash
# Test frontend
curl -I https://grc-client2.completecyber.uk

# Test backend API
curl https://grc-client2.completecyber.uk/api/
```

## Step 4: Adding Additional Clients

### 4.1 Create New Compose File

Use the template to create a new compose file:

```bash
# Copy template
cp docker-compose-client-template.yml docker-compose-grc-client3.yml

# Replace placeholders (example for client 3)
sed -i 's/CLIENT_NAME/grc-client3/g' docker-compose-grc-client3.yml
sed -i 's/CLIENT_DOMAIN/grc-client3.completecyber.uk/g' docker-compose-grc-client3.yml
```

### 4.2 Create New Dokploy App

1. **New App** → **Compose App**
2. **Repository:** `rishiiii9/complete-cyber-assistant-community`
3. **Compose file:** `docker-compose-grc-client3.yml`
4. **Domain:** `grc-client3.completecyber.uk`
5. **Deploy**

## Step 5: Management and Monitoring

### 5.1 Application Dashboard

**Dokploy Dashboard Features:**
- Individual app monitoring
- Separate log viewing
- Resource usage tracking
- Independent scaling controls

### 5.2 Health Monitoring

**Per-Client Health Checks:**
```bash
# Client 1 Health Check
curl -f https://grc-client1.completecyber.uk/api/health/ || echo "Client 1 Down"

# Client 2 Health Check  
curl -f https://grc-client2.completecyber.uk/api/health/ || echo "Client 2 Down"
```

### 5.3 Log Management

**Access Logs:**
- Dokploy Dashboard → App → Logs
- Separate log streams per client
- Real-time log monitoring

## Step 6: Updates and Maintenance

### 6.1 Individual App Updates

**Update Single Client:**
1. **Push new images** to registry
2. **Go to specific app** in Dokploy
3. **Click "Redeploy"**
4. **Monitor deployment**

### 6.2 Bulk Updates

**Update All Clients:**
```bash
# Script to update all clients
#!/bin/bash
CLIENTS=("grc-client1" "grc-client2" "grc-client3")

for client in "${CLIENTS[@]}"; do
    echo "Updating $client..."
    # Trigger redeploy via Dokploy API or dashboard
done
```

### 6.3 Backup Strategy

**Per-Client Backups:**
- Database backups per client
- Volume snapshots
- Configuration backups

## Step 7: Security Considerations

### 7.1 Isolation

**Complete Isolation:**
- Separate databases per client
- Independent volumes
- Isolated networks
- Unique credentials

### 7.2 Access Control

**Client-Specific Access:**
- Separate admin accounts
- Client-specific user management
- Individual audit logs

### 7.3 SSL/TLS

**SSL Configuration:**
- Individual SSL certificates
- Automatic certificate renewal
- HTTPS enforcement

## Step 8: Scaling and Performance

### 8.1 Resource Allocation

**Per-Client Resources:**
- CPU allocation based on usage
- Memory allocation per client
- Storage allocation per client

### 8.2 Performance Monitoring

**Monitor Per Client:**
- Response times
- Resource usage
- Error rates
- User activity

## Troubleshooting

### Common Issues

**1. DNS Issues**
```bash
# Check DNS resolution
dig grc-client1.completecyber.uk
dig grc-client2.completecyber.uk
```

**2. SSL Certificate Issues**
- Verify domain ownership
- Check DNS propagation
- Monitor certificate renewal

**3. Database Connection Issues**
- Verify client-specific credentials
- Check database health
- Monitor connection limits

**4. Resource Issues**
- Monitor resource usage
- Scale up if needed
- Optimize resource allocation

### Debug Commands

```bash
# Check specific client deployment
docker ps --filter "label=com.docker.compose.project=grc-client1"

# View client-specific logs
docker logs grc-client1_backend_1

# Test client-specific connectivity
curl -v https://grc-client1.completecyber.uk/api/
```

## Cost Optimization

### 8.1 Resource Management

**Optimize Per Client:**
- Right-size resource allocation
- Monitor usage patterns
- Scale down during low usage

### 8.2 Storage Optimization

**Efficient Storage:**
- Regular cleanup of old data
- Optimize database queries
- Monitor storage growth

## Quick Reference

**Client URLs:**
- Client 1: https://grc-client1.completecyber.uk
- Client 2: https://grc-client2.completecyber.uk
- Client 3: https://grc-client3.completecyber.uk

**Admin Access:**
- Client 1: admin@grc-client1.completecyber.uk
- Client 2: admin@grc-client2.completecyber.uk
- Client 3: admin@grc-client3.completecyber.uk

**Compose Files:**
- `docker-compose-grc-client1.yml`
- `docker-compose-grc-client2.yml`
- `docker-compose-grc-client3.yml`

**Key Commands:**
```bash
# Deploy all clients
for client in client1 client2 client3; do
    echo "Deploying $client..."
    # Dokploy deployment command
done

# Health check all clients
for domain in grc-client1.completecyber.uk grc-client2.completecyber.uk; do
    curl -f https://$domain/api/health/ || echo "$domain is down"
done
```

## Support and Maintenance

### Regular Tasks

**Daily:**
- Monitor all client deployments
- Check error logs
- Verify SSL certificates

**Weekly:**
- Review resource usage
- Update security patches
- Backup verification

**Monthly:**
- Performance review
- Cost optimization
- Security audit

### Contact Information

- **Dokploy Support:** For platform issues
- **Development Team:** For application issues
- **Infrastructure Team:** For DNS/SSL issues
