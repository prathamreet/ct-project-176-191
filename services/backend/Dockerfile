# Build stage
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm prune --production

# Production stage
FROM node:18-slim
WORKDIR /app
COPY --from=builder /app ./
EXPOSE 5000
CMD ["node", "server.js"]
