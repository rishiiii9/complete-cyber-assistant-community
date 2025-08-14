# syntax=docker/dockerfile:1

FROM node:20-slim AS build
WORKDIR /app/frontend

ENV PNPM_HOME=/root/.local/share/pnpm \
    PATH=/root/.local/share/pnpm:$PATH

# Increase Node heap to avoid OOM during Vite/SvelteKit build
ENV NODE_OPTIONS=--max-old-space-size=4096

RUN corepack enable && corepack prepare pnpm@9.15.2 --activate

COPY package.json pnpm-lock.yaml ./
COPY project.inlang ./project.inlang
COPY plugins ./plugins

RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm run build

FROM node:20-slim AS runner
WORKDIR /app/frontend

ENV PNPM_HOME=/root/.local/share/pnpm \
    PATH=/root/.local/share/pnpm:$PATH

RUN corepack enable && corepack prepare pnpm@9.15.2 --activate

# Copy package manager files for prod install
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod --frozen-lockfile --ignore-scripts

# Copy built app and server launcher
COPY --from=build /app/frontend/build ./build
COPY --from=build /app/frontend/server ./server

ENV NODE_ENV=production \
    PORT=8080 \
    HOST=0.0.0.0

EXPOSE 8080

CMD ["node", "server/index.js"]


