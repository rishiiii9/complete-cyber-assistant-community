# Multi-Instance Dokploy Quick Reference

## 🚀 Quick Start

### 1. Create New Client Instance
```bash
# Create a new client instance
./scripts/create-client-instance.sh grc-client3 grc-client3.completecyber.uk
```

### 2. Deploy to Dokploy
1. **DNS Setup:** Add A record for `grc-client3.completecyber.uk`
2. **Dokploy App:** Create new Compose App
3. **Repository:** `rishiiii9/complete-cyber-assistant-community`
4. **Compose File:** `docker-compose-grc-client3.yml`
5. **Environment:** Copy from `env-grc-client3.txt`
6. **Domain:** `grc-client3.completecyber.uk`
7. **Deploy**

## 📋 Management Commands

### Health Checks
```bash
# Check all clients
./scripts/manage-all-clients.sh health-check

# Check specific client
./health-check-grc-client1.sh
```

### Client Management
```bash
# List all clients
./scripts/manage-all-clients.sh list

# Show status
./scripts/manage-all-clients.sh status

# Create backup
./scripts/manage-all-clients.sh backup

# Update all clients
./scripts/manage-all-clients.sh update
```

### Individual Client Operations
```bash
# View logs
./scripts/manage-all-clients.sh logs grc-client1

# Restart client
./scripts/manage-all-clients.sh restart grc-client1
```

## 🌐 Client URLs

| Client | URL | Admin Email |
|--------|-----|-------------|
| GRC Client 1 | https://grc-client1.completecyber.uk | admin@grc-client1.completecyber.uk |
| GRC Client 2 | https://grc-client2.completecyber.uk | admin@grc-client2.completecyber.uk |
| GRC Client 3 | https://grc-client3.completecyber.uk | admin@grc-client3.completecyber.uk |

## 📁 File Structure

```
├── docker-compose-grc-client1.yml    # Client 1 configuration
├── docker-compose-grc-client2.yml    # Client 2 configuration
├── docker-compose-client-template.yml # Template for new clients
├── env-grc-client1.txt              # Client 1 environment variables
├── env-grc-client2.txt              # Client 2 environment variables
├── deployment-checklist-grc-client1.md # Client 1 deployment guide
├── health-check-grc-client1.sh      # Client 1 health check
├── scripts/
│   ├── create-client-instance.sh    # Create new client script
│   └── manage-all-clients.sh        # Manage all clients script
└── MULTI_INSTANCE_DOKPLOY_GUIDE.md  # Complete setup guide
```

## 🔧 Environment Variables

### Backend (Per Client)
```
DJANGO_SETTINGS_MODULE=ciso_assistant.settings
DJANGO_DEBUG=False
ALLOWED_HOSTS=grc-client1.completecyber.uk,*.dokploy.com
CISO_ASSISTANT_URL=https://grc-client1.completecyber.uk
POSTGRES_NAME=ciso_assistant_grc-client1
POSTGRES_USER=ciso_assistant_grc-client1
POSTGRES_PASSWORD=<generated-secure-password>
DB_HOST=db
DB_PORT=5432
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_HOST_USER=ejones@completecyber.uk
EMAIL_HOST_PASSWORD=vwrahbxebhmrzidy
EMAIL_USE_TLS=True
DEFAULT_FROM_EMAIL=ejones@completecyber.uk
DJANGO_SUPERUSER_EMAIL=admin@grc-client1.completecyber.uk
DJANGO_SUPERUSER_PASSWORD=<generated-secure-password>
```

### Frontend (Per Client)
```
NODE_ENV=production
PUBLIC_BACKEND_API_URL=http://backend:8000/api
PORT=3000
HOST=0.0.0.0
```

## 🛠️ Troubleshooting

### Common Issues

**DNS Issues:**
```bash
# Check DNS resolution
nslookup grc-client1.completecyber.uk
dig grc-client1.completecyber.uk
```

**SSL Issues:**
```bash
# Check SSL certificate
openssl s_client -connect grc-client1.completecyber.uk:443 -servername grc-client1.completecyber.uk
```

**Connectivity Issues:**
```bash
# Test frontend
curl -I https://grc-client1.completecyber.uk

# Test backend API
curl https://grc-client1.completecyber.uk/api/
```

### Dokploy Dashboard

**Access Logs:**
1. Go to Dokploy Dashboard
2. Select client app
3. Click "Logs" tab
4. Choose service (backend/frontend/huey)

**Restart Service:**
1. Go to Dokploy Dashboard
2. Select client app
3. Click "Restart" or "Redeploy"

**Monitor Resources:**
1. Go to Dokploy Dashboard
2. Select client app
3. View resource usage
4. Scale if needed

## 🔒 Security Checklist

- [ ] Each client has unique database credentials
- [ ] SSL certificates are valid and auto-renewing
- [ ] Admin passwords are secure and unique
- [ ] Environment variables are properly set
- [ ] DNS records are correctly configured
- [ ] Regular backups are scheduled
- [ ] Monitoring is in place

## 📊 Monitoring

### Health Check Endpoints
- Frontend: `https://grc-client1.completecyber.uk`
- Backend API: `https://grc-client1.completecyber.uk/api/`
- SSL Certificate: Valid and auto-renewing

### Resource Monitoring
- CPU Usage per client
- Memory Usage per client
- Storage Usage per client
- Network Traffic per client

## 🚨 Emergency Procedures

### Client Down
1. Check Dokploy dashboard for app status
2. View logs for error messages
3. Restart the application
4. Verify DNS and SSL
5. Run health check script

### All Clients Down
1. Check Dokploy platform status
2. Verify DNS configuration
3. Check SSL certificate renewal
4. Review recent deployments
5. Contact Dokploy support if needed

## 📞 Support Contacts

- **Dokploy Support:** Platform issues
- **Development Team:** Application issues
- **Infrastructure Team:** DNS/SSL issues

## 🔄 Update Process

### Individual Client Update
1. Push new images to registry
2. Go to specific client in Dokploy
3. Click "Redeploy"
4. Monitor deployment logs
5. Run health check

### Bulk Update All Clients
1. Push new images to registry
2. Run: `./scripts/manage-all-clients.sh update`
3. Follow prompts for each client
4. Monitor all deployments
5. Run health check for all clients

## 💰 Cost Optimization

### Resource Allocation
- Start with minimal resources (1 vCPU, 2GB RAM)
- Scale up based on usage patterns
- Monitor resource usage regularly
- Scale down during low usage periods

### Storage Management
- Regular cleanup of old data
- Monitor storage growth
- Optimize database queries
- Archive old backups

---

**Last Updated:** $(date)
**Version:** 1.0
