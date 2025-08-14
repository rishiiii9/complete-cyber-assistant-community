# Dokploy Deployment Troubleshooting Guide

## Issues Fixed

### 1. Port Conflict Error
**Error:** `Bind for 0.0.0.0:3000 failed: port is already allocated`

**Solution:** 
- Changed frontend port from 3000 to 8080
- Updated `docker-compose-dokploy.yml` to use port 8080
- Updated frontend Dockerfile to expose port 8080 by default

### 2. Image Pull Access Denied
**Error:** `pull access denied for ciso-assistant-backend, repository does not exist`

**Solution:**
- Verified images exist in GitHub Container Registry: `ghcr.io/rishiiii9/complete-cyber-backend:latest` and `ghcr.io/rishiiii9/complete-cyber-frontend:latest`
- Updated Docker Compose file to use correct image names
- Rebuilt and pushed updated frontend image with port 8080

## Updated Files

### 1. `docker-compose-dokploy.yml` (NEW)
- Uses port 8080 for frontend instead of 3000
- Correct image references: `ghcr.io/rishiiii9/complete-cyber-backend:latest`
- Updated environment variables to use port 8080

### 2. `frontend/Dockerfile`
- Changed default port from 3000 to 8080
- Updated EXPOSE directive

## Deployment Steps

### 1. Use the Correct Compose File
In Dokploy, use `docker-compose-dokploy.yml` instead of `docker-compose-registry.yml`

### 2. Verify Image Availability
```bash
# Test image pulls locally
docker pull ghcr.io/rishiiii9/complete-cyber-backend:latest
docker pull ghcr.io/rishiiii9/complete-cyber-frontend:latest
```

### 3. Dokploy Configuration
- **Compose File:** `docker-compose-dokploy.yml`
- **Port:** 8080 (frontend)
- **Backend API:** Available on port 8000

### 4. Environment Variables (if needed)
If you need to customize the deployment, you can set these in Dokploy:
- `POSTGRES_PASSWORD`: Change from default `ciso_assistant`
- `DJANGO_SUPERUSER_EMAIL`: For admin user creation
- `DJANGO_SUPERUSER_PASSWORD`: For admin user creation

## Service URLs After Deployment
- **Frontend:** `https://your-dokploy-domain.com:8080`
- **Backend API:** `https://your-dokploy-domain.com:8000`
- **Database:** Internal (PostgreSQL on port 5432)

## Health Checks
- Database: PostgreSQL health check every 10s
- Backend: Depends on database health
- Frontend: Depends on backend
- Huey: Depends on both database and backend

## Troubleshooting Commands

### Check Service Status
```bash
docker-compose -f docker-compose-dokploy.yml ps
```

### View Logs
```bash
docker-compose -f docker-compose-dokploy.yml logs frontend
docker-compose -f docker-compose-dokploy.yml logs backend
docker-compose -f docker-compose-dokploy.yml logs huey
```

### Test Locally
```bash
# Test the fixed compose file locally
docker-compose -f docker-compose-dokploy.yml up -d
```

## Next Steps
1. Use `docker-compose-dokploy.yml` in your Dokploy deployment
2. The application will be available on port 8080
3. Monitor logs for any additional issues
4. Access the application at your Dokploy domain on port 8080
