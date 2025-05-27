# Stage 1: Build angular image
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npm install -g @angular/cli
COPY . .
RUN npm run build

# Stage 2: Production
FROM nginx:alpine AS production
COPY --from=build /app/dist/angularproject /usr/share/nginx/html
EXPOSE 80
CMD ["nginx" "-g" "daemon off;"]
