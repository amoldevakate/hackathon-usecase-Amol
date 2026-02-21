# ==============================================
# Stage 1: Install production dependencies
# ==============================================
FROM node:18-alpine AS deps

WORKDIR /app

# Copy package files first for better layer caching
COPY package*.json ./

# Install only production dependencies
# Using npm install (not npm ci) as package-lock.json may not exist
RUN npm install --only=production && npm cache clean --force

# ==============================================
# Stage 2: Final production image
# ==============================================
FROM node:18-alpine AS runner

# Install dumb-init for proper PID 1 signal handling
RUN apk add --no-cache dumb-init

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser  -S nodeuser -u 1001 -G nodejs

WORKDIR /app

# Copy production node_modules from deps stage
COPY --from=deps --chown=nodeuser:nodejs /app/node_modules ./node_modules

# Copy application source code
COPY --chown=nodeuser:nodejs src/ ./src/
COPY --chown=nodeuser:nodejs package.json ./

# Switch to non-root user
USER nodeuser

# Expose application port
EXPOSE 3000

# Health check for Kubernetes liveness/readiness probes
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

# Use dumb-init as entrypoint for proper signal handling
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "src/index.js"]
