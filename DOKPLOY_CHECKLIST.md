# Dokploy Deployment Checklist

## ✅ Pre-Deployment Checklist

### 1. Images Ready
- [ ] Backend image built: `complete-cyber-backend:latest`
- [ ] Frontend image built: `complete-cyber-frontend:latest`
- [ ] Images tagged for registry: `ghcr.io/rishiiii9/complete-cyber-*:latest`

### 2. GitHub Setup
- [ ] GitHub Personal Access Token created
- [ ] Token has `write:packages` and `read:packages` permissions
- [ ] Repository accessible: `rishiiii9/complete-cyber-assistant-community`

### 3. Files Ready
- [ ] `docker-compose-registry.yml` - Main compose file
- [ ] `backend/Dockerfile` - Backend image definition
- [ ] `frontend/Dockerfile` - Frontend image definition
- [ ] All `.dockerignore` files in place

## 🚀 Deployment Steps

### Step 1: Push Images
```bash
# Login to registry
echo YOUR_GITHUB_TOKEN | docker login ghcr.io -u rishiiii9 --password-stdin

# Push images
docker push ghcr.io/rishiiii9/complete-cyber-backend:latest
docker push ghcr.io/rishiiii9/complete-cyber-frontend:latest
```

### Step 2: Dokploy Setup
- [ ] Create new Compose App in Dokploy
- [ ] Connect repository: `rishiiii9/complete-cyber-assistant-community`
- [ ] Set compose file: `docker-compose-registry.yml`
- [ ] Configure environment variables (see below)

### Step 3: Environment Variables

**Backend:**
```
DJANGO_SETTINGS_MODULE=ciso_assistant.settings
DJANGO_DEBUG=False
ALLOWED_HOSTS=your-domain.com,*.dokploy.com
CISO_ASSISTANT_URL=https://your-domain.com
POSTGRES_NAME=ciso_assistant
POSTGRES_USER=ciso_assistant
POSTGRES_PASSWORD=your-strong-password
DB_HOST=db
DB_PORT=5432
```

**Frontend:**
```
NODE_ENV=production
PUBLIC_BACKEND_API_URL=http://backend:8000/api
PORT=3000
HOST=0.0.0.0
```

### Step 4: Ports & Volumes
- [ ] Frontend port 3000 → Public
- [ ] Backend port 8000 → Internal
- [ ] Database port 5432 → Internal
- [ ] Volume `db_data` → Postgres data
- [ ] Volume `backend_data` → `/app/backend/db`

### Step 5: Deploy
- [ ] Click "Deploy" in Dokploy
- [ ] Wait 2-5 minutes for deployment
- [ ] Check logs for any errors
- [ ] Test frontend access
- [ ] Verify backend API connectivity

## 🔍 Post-Deployment Verification

### Health Checks
- [ ] Frontend loads at Dokploy URL
- [ ] Backend API responds (auth error is expected)
- [ ] Database is healthy
- [ ] All services are running

### Testing
- [ ] Frontend: `https://your-app.dokploy.com`
- [ ] Backend API: `https://your-app.dokploy.com/api/`
- [ ] Database connections working
- [ ] File uploads working (if applicable)

## 🛠️ Troubleshooting Quick Reference

### Common Issues
1. **Images not found** → Check registry login and push
2. **Database connection** → Verify POSTGRES_* env vars
3. **Frontend can't reach backend** → Check PUBLIC_BACKEND_API_URL
4. **Permission denied** → Verify GitHub token permissions

### Debug Commands
```bash
# Check images in registry
docker pull ghcr.io/rishiiii9/complete-cyber-backend:latest

# Test locally
docker compose -f docker-compose-registry.yml up -d

# Check logs
docker compose -f docker-compose-registry.yml logs -f
```

## 📞 Support

If stuck:
1. Check `DOKPLOY_DEPLOYMENT_GUIDE.md` for detailed steps
2. Review container logs in Dokploy dashboard
3. Test locally first with `docker-compose-registry.yml`
4. Contact Dokploy support if needed

## 🎯 Success Criteria

Your deployment is successful when:
- ✅ Frontend accessible at Dokploy URL
- ✅ Backend API responding (even with auth errors)
- ✅ Database healthy and persistent
- ✅ All services running without errors
- ✅ SSL certificate working (HTTPS)
- ✅ Environment variables properly set
