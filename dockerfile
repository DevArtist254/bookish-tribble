# --- Stage 1: Base & Dep ---

FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /

# --- STAGE 2: Builder ---
FROM base AS builder
COPY package.json pnpm-lock.yaml ./
# Install all dependencies (including dev)
RUN pnpm install --frozen-lockfile

# --- STAGE 3: Runner ---
FROM base AS runner
ENV NODE_ENV=production
WORKDIR /

# Copy only the prod dep from the base/builder stage
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod --frozen-lockfile

# EXPOSE the port the app runs on
EXPOSE 3001

# Start the application
CMD ["node", "/server.js"]
