## Deploying with Dokploy using Docker Compose

This repository now includes production-ready Dockerfiles for the backend (Django) and frontend (SvelteKit) and a `docker-compose.yml` suitable for Dokploy.

### Services
- Backend (Django + Gunicorn) on port 8000
- Frontend (SvelteKit adapter-node) on port 3000
- Postgres 16

### Environment
- Frontend expects `PUBLIC_BACKEND_API_URL` → defaults to `http://backend:8000/api` in compose
- Backend reads standard envs: `ALLOWED_HOSTS`, `CISO_ASSISTANT_URL`, `POSTGRES_*`, `DB_HOST`, `DB_PORT`

### Local run
```bash
# from repo root
docker compose up --build -d
# Frontend: http://localhost:3000
# Backend API: http://localhost:8000/api
```

### Dokploy setup (example)
1. Create a new Compose App in Dokploy and point it to this repo.
2. Set build context:
   - Backend service: `./backend`
   - Frontend service: `./frontend`
3. Configure environment variables:
   - Backend: `ALLOWED_HOSTS=<your-domain>`, `CISO_ASSISTANT_URL=https://<your-domain>`
   - Database credentials as needed
4. Expose:
   - Frontend 3000 → public
   - Backend 8000 → internal (only used by frontend)
5. Add persistent volumes:
   - `db_data` → Postgres data
   - `backend_data` → `/app/backend/db` for attachments, secret key, huey file

### Notes
- The backend image installs `xmlsec`, `weasyprint`, and related libraries required by this project.
- Huey uses sqlite file by default and will persist in the `backend_data` volume.
- Set `DJANGO_SUPERUSER_EMAIL` to auto-create the admin on first boot (password is sent by email if mailer is configured).
