# syntax=docker/dockerfile:1

FROM python:3.11-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app/backend

# System dependencies for building wheels and runtime libs for xmlsec, weasyprint, psycopg2
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    gcc \
    pkg-config \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libxmlsec1-dev \
    libxmlsec1-openssl \
    libffi-dev \
    libcairo2 \
    libpango-1.0-0 \
    libpangoft2-1.0-0 \
    libharfbuzz0b \
    libfreetype6 \
    libfribidi0 \
    libgdk-pixbuf-2.0-0 \
    fonts-liberation \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
ENV POETRY_VERSION=1.8.3
RUN curl -sSL https://install.python-poetry.org | python - --version ${POETRY_VERSION} \
    && ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Copy only dependency files first for better caching
COPY pyproject.toml poetry.lock ./

# Configure Poetry to install into the system environment (no venv) and install deps only
RUN poetry config virtualenvs.create false \
    && poetry install --only main --no-interaction --no-ansi

# Copy the backend source code
COPY . .

# Ensure startup script is executable
RUN chmod +x startup.sh

# Expose the application port
EXPOSE 8000

# Default environment suitable for container runtime; override in compose as needed
ENV DJANGO_SETTINGS_MODULE=ciso_assistant.settings \
    DJANGO_DEBUG=False \
    GUNICORN_WORKERS=3 \
    GUNICORN_TIMEOUT=100 \
    GUNICORN_KEEPALIVE=30 \
    GUNICORN_LIMIT_REQUEST_LINE=5120 \
    PORT=8000

# Create db directory to persist secrets/attachments if not mounted
RUN mkdir -p /app/backend/db/attachments

VOLUME ["/app/backend/db"]

ENTRYPOINT ["/app/backend/startup.sh"]


