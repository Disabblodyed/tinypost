FROM node:22.16.0-alpine3.22 AS base

# Étape : installation des dépendances complètes
FROM base AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci

# Étape : installation des dépendances prod uniquement
FROM base AS production-deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

# Étape : build de l’application
FROM base AS build
WORKDIR /app
COPY --from=deps /app/node_modules /app/node_modules
COPY . .
RUN node ace build

# Étape finale : image de production
FROM base
WORKDIR /app

ENV NODE_ENV=production
ENV TZ=UTC

COPY --from=production-deps /app/node_modules ./node_modules
COPY --from=build /app/build ./

EXPOSE 3333
CMD ["node", "./bin/server.js"]
