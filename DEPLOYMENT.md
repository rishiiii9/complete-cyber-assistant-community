# CISO Assistant Deployment Guide

## Overview
This deployment uses Docker Compose to run the CISO Assistant application with local image building instead of pulling from external registries.

## Services

### Database (PostgreSQL)
- **Service**: `db`
- **Image**: `postgres:16`
- **Port**: Internal only (5432)
- **Data**: Persisted in `db_data` volume

### Backend (Django)
- **Service**: `backend`
- **Build**: Local build from `./backend/Dockerfile`
- **Port**: 8000
- **Dependencies**: PostgreSQL database
- **Data**: Persisted in `backend_data` volume

### Frontend (SvelteKit)
- **Service**: `frontend`
- **Build**: Local build from `./frontend/Dockerfile`
- **Port**: 8080
- **Dependencies**: Backend service

### Background Tasks (Huey)
- **Service**: `huey`
- **Build**: Local build from `./backend/Dockerfile`
- **Command**: Runs Django management command for background tasks
- **Dependencies**: Database and backend

## Deployment

### Prerequisites
- Docker and Docker Compose installed
- Git repository cloned locally

### Quick Start
```bash
# Build and start all services
docker compose -f docker-compose-dokploy.yml up -d --build

# View logs
docker compose -f docker-compose-dokploy.yml logs -f

# Stop services
docker compose -f docker-compose-dokploy.yml down
```

### Environment Variables
The following environment variables can be customized:

#### Backend
- `DJANGO_SUPERUSER_EMAIL`: Email for initial admin user
- `DJANGO_SUPERUSER_PASSWORD`: Password for initial admin user
- `DJANGO_DEBUG`: Set to "True" for development
- `ALLOWED_HOSTS`: Comma-separated list of allowed hosts

#### Database
- `POSTGRES_DB`: Database name (default: ciso_assistant)
- `POSTGRES_USER`: Database user (default: ciso_assistant)
- `POSTGRES_PASSWORD`: Database password (default: ciso_assistant)

## Access
- **Frontend**: http://localhost:8080
- **Backend API**: http://localhost:8000/api

## Troubleshooting

### Build Issues
If you encounter build issues:
1. Ensure Docker has sufficient resources (memory, disk space)
2. Check that all required files are present in the repository
3. Verify Docker and Docker Compose versions are up to date

### Database Connection Issues
- Ensure the database service is healthy before starting backend
- Check database credentials match between services
- Verify database volume permissions

### Port Conflicts
If ports 8000 or 8080 are already in use, modify the port mappings in the compose file:
```yaml
ports:
  - "8001:8000"  # Map host port 8001 to container port 8000
```

## Data Persistence
- Database data is stored in the `db_data` volume
- Backend attachments and secrets are stored in the `backend_data` volume
- Volumes persist across container restarts and updates
