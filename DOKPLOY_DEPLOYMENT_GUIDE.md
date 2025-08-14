# Dokploy Deployment Guide - Complete Cyber Assistant

This guide provides detailed steps to deploy your Complete Cyber Assistant to Dokploy using pre-built Docker images.

## Prerequisites

- ✅ Docker images built locally
- ✅ GitHub repository with your code
- ✅ Dokploy account
- ✅ GitHub Personal Access Token (for pushing images)

## Step 1: Push Images to GitHub Container Registry

### 1.1 Create GitHub Personal Access Token

1. Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Give it a name like "Docker Registry Access"
4. Select scopes: `write:packages`, `read:packages`
5. Copy the token (you'll need it for the next step)

### 1.2 Login to GitHub Container Registry

```bash
# Login to GitHub Container Registry
echo YOUR_GITHUB_TOKEN | docker login ghcr.io -u rishiiii9 --password-stdin
```

### 1.3 Push Your Images

```bash
# Push backend image
docker push ghcr.io/rishiiii9/complete-cyber-backend:latest

# Push frontend image
docker push ghcr.io/rishiiii9/complete-cyber-frontend:latest
```

### 1.4 Verify Images are Available

```bash
# Check if images are accessible
docker pull ghcr.io/rishiiii9/complete-cyber-backend:latest
docker pull ghcr.io/rishiiii9/complete-cyber-frontend:latest
```

## Step 2: Dokploy Setup

### 2.1 Create New Compose App

1. **Login to Dokploy** dashboard
2. **Click "New App"** → **"Compose App"**
3. **Connect Repository:**
   - Repository: `rishiiii9/complete-cyber-assistant-community`
   - Branch: `main`
   - Compose file path: `docker-compose-registry.yml`

### 2.2 Configure Build Settings

**Important:** Since we're using pre-built images, you don't need build contexts.

**Backend Service:**
- Build context: Leave empty (not needed for pre-built images)
- Image: `ghcr.io/rishiiii9/complete-cyber-backend:latest`

**Frontend Service:**
- Build context: Leave empty (not needed for pre-built images)  
- Image: `ghcr.io/rishiiii9/complete-cyber-frontend:latest`

### 2.3 Set Environment Variables

**Backend Environment Variables:**
```
DJANGO_SETTINGS_MODULE=ciso_assistant.settings
DJANGO_DEBUG=False
ALLOWED_HOSTS=your-domain.com,*.dokploy.com
CISO_ASSISTANT_URL=https://your-domain.com
POSTGRES_NAME=ciso_assistant
POSTGRES_USER=ciso_assistant
POSTGRES_PASSWORD=your-strong-password-here
DB_HOST=db
DB_PORT=5432
```

**Frontend Environment Variables:**
```
NODE_ENV=production
PUBLIC_BACKEND_API_URL=http://backend:8000/api
PORT=3000
HOST=0.0.0.0
```

**Optional - Create Admin User:**
```
DJANGO_SUPERUSER_EMAIL=admin@your-domain.com
DJANGO_SUPERUSER_PASSWORD=your-admin-password
```

### 2.4 Configure Ports

**Port Configuration:**
- **Frontend**: Expose port `3000` publicly
- **Backend**: Keep port `8000` internal (only used by frontend)
- **Database**: Keep port `5432` internal

### 2.5 Configure Volumes

**Persistent Volumes:**
- `db_data` → Postgres data persistence
- `backend_data` → `/app/backend/db` (for attachments, secret key, huey file)

## Step 3: Deploy

### 3.1 Initial Deployment

1. **Review your configuration** in Dokploy
2. **Click "Deploy"**
3. **Wait for deployment** (should take 2-5 minutes)
4. **Monitor logs** for any issues

### 3.2 Verify Deployment

**Check Services:**
- Frontend should be accessible at your Dokploy URL
- Backend API should be working internally
- Database should be running and healthy

**Test Endpoints:**
```bash
# Test frontend (replace with your Dokploy URL)
curl https://your-app.dokploy.com

# Test backend API (should return auth error, which is expected)
curl https://your-app.dokploy.com/api/
```

## Step 4: Post-Deployment Configuration

### 4.1 Create Admin User (if not done via env vars)

```bash
# Access backend container
docker exec -it your-backend-container bash

# Create superuser
python manage.py createsuperuser
```

### 4.2 Configure Domain (Optional)

1. **Add Custom Domain** in Dokploy settings
2. **Update DNS** to point to Dokploy
3. **Update Environment Variables:**
   - `ALLOWED_HOSTS=your-domain.com`
   - `CISO_ASSISTANT_URL=https://your-domain.com`

### 4.3 SSL Certificate

- Dokploy should automatically provision SSL certificates
- Verify HTTPS is working correctly

## Step 5: Monitoring & Maintenance

### 5.1 View Logs

```bash
# In Dokploy dashboard
- Go to your app
- Click on "Logs" tab
- Monitor for errors or issues
```

### 5.2 Health Checks

**Backend Health:**
- Check if Django is responding
- Verify database connections
- Monitor Huey worker status

**Frontend Health:**
- Verify SvelteKit is serving pages
- Check API connectivity to backend

### 5.3 Updates

**To Update Your Application:**

1. **Build New Images:**
   ```bash
   docker build -t complete-cyber-backend:latest ./backend
   docker build -t complete-cyber-frontend:latest ./frontend
   ```

2. **Tag and Push:**
   ```bash
   docker tag complete-cyber-backend:latest ghcr.io/rishiiii9/complete-cyber-backend:latest
   docker tag complete-cyber-frontend:latest ghcr.io/rishiiii9/complete-cyber-frontend:latest
   docker push ghcr.io/rishiiii9/complete-cyber-backend:latest
   docker push ghcr.io/rishiiii9/complete-cyber-frontend:latest
   ```

3. **Redeploy in Dokploy:**
   - Go to your app in Dokploy
   - Click "Redeploy" or "Update"

## Troubleshooting

### Common Issues

**1. Images Not Found**
```bash
# Verify images exist in registry
docker pull ghcr.io/rishiiii9/complete-cyber-backend:latest
```

**2. Database Connection Issues**
- Check `DB_HOST`, `DB_PORT`, `POSTGRES_*` environment variables
- Verify database service is healthy

**3. Frontend Can't Connect to Backend**
- Check `PUBLIC_BACKEND_API_URL` environment variable
- Verify backend service is running
- Check internal networking

**4. Permission Issues**
- Ensure GitHub token has correct permissions
- Check repository access

### Debug Commands

```bash
# Check container status
docker ps

# View container logs
docker logs container-name

# Access container shell
docker exec -it container-name bash

# Check environment variables
docker exec container-name env
```

## Security Considerations

### 1. Environment Variables
- Use strong passwords for database
- Don't commit secrets to repository
- Use Dokploy's secret management

### 2. Network Security
- Keep backend port internal
- Only expose frontend port publicly
- Use HTTPS for all external traffic

### 3. Image Security
- Regularly update base images
- Scan images for vulnerabilities
- Use specific image tags instead of `latest`

## Cost Optimization

### 1. Resource Allocation
- Start with minimal resources
- Scale up based on usage
- Monitor resource usage

### 2. Image Optimization
- Use multi-stage builds
- Minimize image layers
- Remove unnecessary files

## Support

If you encounter issues:

1. **Check Dokploy Documentation**
2. **Review Container Logs**
3. **Verify Environment Variables**
4. **Test Locally First**
5. **Contact Dokploy Support**

## Quick Reference

**Essential Files:**
- `docker-compose-registry.yml` - Main compose file for Dokploy
- `backend/Dockerfile` - Backend image definition
- `frontend/Dockerfile` - Frontend image definition

**Key Commands:**
```bash
# Build and push images
docker build -t complete-cyber-backend:latest ./backend
docker build -t complete-cyber-frontend:latest ./frontend
docker tag complete-cyber-backend:latest ghcr.io/rishiiii9/complete-cyber-backend:latest
docker tag complete-cyber-frontend:latest ghcr.io/rishiiii9/complete-cyber-frontend:latest
docker push ghcr.io/rishiiii9/complete-cyber-backend:latest
docker push ghcr.io/rishiiii9/complete-cyber-frontend:latest

# Test locally
docker compose -f docker-compose-registry.yml up -d
```

**Environment Variables Summary:**
- Backend: `DJANGO_SETTINGS_MODULE`, `ALLOWED_HOSTS`, `CISO_ASSISTANT_URL`, `POSTGRES_*`, `DB_*`
- Frontend: `NODE_ENV`, `PUBLIC_BACKEND_API_URL`, `PORT`, `HOST`
