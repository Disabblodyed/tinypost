FROM node:20-alpine

WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm ci --only=production

# Copier le code source
COPY . .

# Build l'application
RUN node ace build

# Exposer le port
EXPOSE 3333

# Commande de démarrage
CMD ["node", "build/bin/server.js"]