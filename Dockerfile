FROM node:20-alpine

WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer TOUTES les dépendances (dev incluses pour le build)
RUN npm ci

# Copier le code source
COPY . .

# Build l'application
RUN node ace build

# Se déplacer dans le dossier build et installer seulement les dépendances de production
WORKDIR /app/build
RUN npm ci --omit="dev"

# Exposer le port
EXPOSE 3333

# Commande de démarrage
CMD ["node", "bin/server.js"]
