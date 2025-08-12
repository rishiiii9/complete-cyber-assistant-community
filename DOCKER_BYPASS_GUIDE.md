# Docker Authentication Bypass Guide

This guide shows you how to bypass authentication in CISO Assistant using Docker for local development.

## 🚀 Quick Start (Recommended)

### Option 1: Use the Automated Script

```bash
cd config
./start-dev-bypass.sh
```

This script automatically:
- Stops existing containers
- Starts services with authentication bypass
- Shows service status
- Provides helpful commands

### Option 2: Manual Docker Compose

```bash
cd config
docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml up -d
```

## 🔧 How It Works

The bypass works by using Docker Compose override files that add environment variables:

### Backend Bypass
- `DEVELOPMENT_MODE=True` - Enables development features
- `BYPASS_AUTH=True` - Signals authentication bypass
- `DJANGO_DEBUG=True` - Enables debug mode
- `MAIL_DEBUG=True` - Shows emails in console

### Frontend Bypass
- `BYPASS_AUTH=true` - Enables frontend bypass
- `NODE_ENV=development` - Sets development mode

## 📁 File Structure

```
config/
├── docker-compose-barebone.yml          # Base configuration
├── docker-compose.override.yml          # Development override (bypass)
├── start-dev-bypass.sh                  # Automated startup script
└── docker-compose-dev-bypass.yml        # Alternative full config
```

## 🌐 Access Points

After starting the services:

- **Frontend**: http://localhost:3000 (Authentication bypassed)
- **Backend API**: http://localhost:8000/api
- **Backend Admin**: http://localhost:8000/admin (if needed)

## 🛠️ Development Features

### Code Mounting
- Backend code is mounted to `/code` in containers
- Frontend code is mounted to `/app` in containers
- Changes to local code are reflected immediately

### Environment Variables
All bypass settings are configured via environment variables in the override file.

## 📝 Useful Commands

### View Logs
```bash
# All services
docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml logs -f

# Specific service
docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml logs -f backend
```

### Stop Services
```bash
docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml down
```

### Restart Services
```bash
docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml restart
```

### Check Status
```bash
docker-compose -f docker-compose-barebone.yml -f docker-compose.override.yml ps
```

## 🔒 Security Notes

⚠️ **IMPORTANT**: This bypass is for development only!

- Never use in production
- Never use in staging
- Never commit bypass configurations to production branches
- Always verify authentication is enabled before deployment

## 🐛 Troubleshooting

### Services Won't Start
1. Check Docker is running: `docker info`
2. Check port conflicts: `lsof -i :3000` and `lsof -i :8000`
3. Check Docker Compose version: `docker-compose --version`

### Authentication Still Required
1. Verify override file is being used
2. Check environment variables: `docker-compose config`
3. Restart containers: `docker-compose restart`

### Code Changes Not Reflecting
1. Check volume mounts are correct
2. Restart the specific service
3. Verify file permissions

## 🔄 Alternative Approaches

### Option 1: Full Custom Compose File
Use `docker-compose-dev-bypass.yml` for a complete custom configuration.

### Option 2: Environment File
Create a `.env` file with bypass variables (not recommended for security).

### Option 3: Command Line Override
```bash
docker-compose -f docker-compose-barebone.yml up -d \
  -e BYPASS_AUTH=true \
  -e DJANGO_DEBUG=True
```

## 📚 Next Steps

1. **Start the services** using one of the methods above
2. **Access the frontend** at http://localhost:3000
3. **Verify bypass works** - no login should be required
4. **Start developing** - make changes to your local code
5. **Check logs** if you encounter issues

## 🆘 Need Help?

If you encounter issues:

1. Check the troubleshooting section above
2. Review Docker logs for error messages
3. Verify all environment variables are set correctly
4. Ensure Docker and Docker Compose are up to date

---

**Happy Developing! 🎉**
