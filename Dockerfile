FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci --only=production

FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules

COPY . .


RUN chown -R node:node /app

USER node

EXPOSE 3000

ENV PORT=3000
ENV DB_HOST=localhost
ENV DB_USER=root
ENV DB_NAME=proyecto_db
ENV DB_PORT=3306

CMD ["node", "server.js"]