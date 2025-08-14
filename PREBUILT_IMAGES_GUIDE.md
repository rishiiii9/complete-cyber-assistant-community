# Using Pre-built Docker Images Guide

This guide shows you how to use your own pre-built Docker images instead of building from source.

## Method 1: Local Pre-built Images

### Step 1: Build Your Images Locally

```bash
# Build backend image
docker build -t complete-cyber-backend:latest ./backend

# Build frontend image  
docker build -t complete-cyber-frontend:latest ./frontend
```

### Step 2: Use Local Images

```bash
# Run with local pre-built images
docker compose -f docker-compose-prebuilt.yml up -d

# Check status
docker compose -f docker-compose-prebuilt.yml ps

# View logs
docker compose -f docker-compose-prebuilt.yml logs -f
```

### Step 3: Stop Services

```bash
docker compose -f docker-compose-prebuilt.yml down
```

## Method 2: Registry Images (Recommended for Dokploy)

### Step 1: Tag for Registry

```bash
# Tag for GitHub Container Registry
docker tag complete-cyber-backend:latest ghcr.io/rishiiii9/complete-cyber-backend:latest
docker tag complete-cyber-frontend:latest ghcr.io/rishiiii9/complete-cyber-frontend:latest
```

### Step 2: Push to Registry

```bash
# Login to GitHub Container Registry
echo $GITHUB_TOKEN | docker login ghcr.io -u rishiiii9 --password-stdin

# Push images
docker push ghcr.io/rishiiii9/complete-cyber-backend:latest
docker push ghcr.io/rishiiii9/complete-cyber-frontend:latest
```

### Step 3: Use Registry Images

```bash
# Run with registry images
docker compose -f docker-compose-registry.yml up -d
```

## Method 3: Dokploy Deployment with Pre-built Images

### Step 1: Use Registry Compose File

In Dokploy, use `docker-compose-registry.yml` as your compose file.

### Step 2: Configure Environment Variables

**Backend:**
```
DJANGO_SETTINGS_MODULE=ciso_assistant.settings
DJANGO_DEBUG=False
ALLOWED_HOSTS=your-domain.com
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

### Step 3: Configure Ports & Volumes

- **Frontend**: Expose port `3000` publicly
- **Backend**: Keep port `8000` internal
- **Volumes**: 
  - `db_data` → Postgres persistence
  - `backend_data` → `/app/backend/db`

## Method 4: Custom Image Names

### Step 1: Build with Custom Names

```bash
# Build with your own naming convention
docker build -t mycompany/cyber-assistant-backend:v1.0.0 ./backend
docker build -t mycompany/cyber-assistant-frontend:v1.0.0 ./frontend
```

### Step 2: Create Custom Compose File

```yaml
services:
  backend:
    image: mycompany/cyber-assistant-backend:v1.0.0
    # ... rest of config
  
  frontend:
    image: mycompany/cyber-assistant-frontend:v1.0.0
    # ... rest of config
```

## Method 5: Multi-Architecture Images

### Step 1: Build for Multiple Platforms

```bash
# Create multi-platform images
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 -t complete-cyber-backend:latest ./backend --push
docker buildx build --platform linux/amd64,linux/arm64 -t complete-cyber-frontend:latest ./frontend --push
```

## Troubleshooting

### Image Not Found
```bash
# Check if image exists
docker images | grep complete-cyber

# Pull from registry if needed
docker pull ghcr.io/rishiiii9/complete-cyber-backend:latest
```

### Permission Issues
```bash
# Fix permissions
sudo chown -R $USER:$USER ./backend ./frontend
```

### Build Failures
```bash
# Clean build cache
docker builder prune -f

# Rebuild without cache
docker build --no-cache -t complete-cyber-backend:latest ./backend
```

## Best Practices

1. **Version Your Images**: Use semantic versioning (v1.0.0, v1.1.0, etc.)
2. **Use Specific Tags**: Avoid `latest` in production
3. **Scan Images**: Use `docker scan` to check for vulnerabilities
4. **Optimize Size**: Use multi-stage builds and .dockerignore files
5. **Document Dependencies**: Keep track of what each image contains

## File Structure

```
├── docker-compose.yml              # Original (builds from source)
├── docker-compose-prebuilt.yml     # Uses local pre-built images
├── docker-compose-registry.yml     # Uses registry images
├── backend/Dockerfile              # Backend image definition
├── frontend/Dockerfile             # Frontend image definition
└── PREBUILT_IMAGES_GUIDE.md       # This guide
```

## Quick Commands Reference

```bash
# Build images
docker build -t complete-cyber-backend:latest ./backend
docker build -t complete-cyber-frontend:latest ./frontend

# Run with pre-built images
docker compose -f docker-compose-prebuilt.yml up -d

# Run with registry images
docker compose -f docker-compose-registry.yml up -d

# Check status
docker compose -f docker-compose-prebuilt.yml ps

# View logs
docker compose -f docker-compose-prebuilt.yml logs -f

# Stop services
docker compose -f docker-compose-prebuilt.yml down
```
