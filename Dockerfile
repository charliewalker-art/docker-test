# Étape 1 : Construction
FROM node:20-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Étape 2 : Serveur de production (Nginx)
FROM nginx:stable-alpine

# On crée le sous-dossier correspondant à la "base" de Vite
RUN mkdir -p /usr/share/nginx/html/docker-test

# On copie le contenu du build dans ce sous-dossier spécifique
COPY --from=build /app/dist /usr/share/nginx/html/docker-test

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]