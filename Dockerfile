# --- STAGE 1: Build Stage ---
FROM node:22-slim 

RUN npm install -g pnpm@latest-10

# Copy dependency files first for better caching
COPY package*.json ./

RUN pnpm install
# Copy the rest of the application
COPY . .

# Start the Express server
CMD ["node", "server.js"]
