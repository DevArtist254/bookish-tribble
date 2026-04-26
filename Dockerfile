# --- STAGE 1: Build Stage ---
FROM node:20-slim AS builder

# Install pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app

# Copy dependency files first (for better caching)
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy the rest of the code and build
COPY . .
RUN pnpm build

# --- STAGE 2: Production Stage ---
FROM node:20-slim AS runner

ENV NODE_ENV=production
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corego enable

WORKDIR /app

# Install only production dependencies for the Express server
COPY package.json pnpm-lock.yaml* ./
RUN corepack enable && pnpm install --prod --frozen-lockfile

# Copy the built static files from the builder stage
# NOTE: Change 'dist' to 'build' if your project uses a different output folder
COPY --from=builder /app/dist ./dist

# Copy the server.js we created above
COPY server.js ./

# Expose the requested port
EXpose 3001

# Start the Express server
CMD ["node", "server.js"]
