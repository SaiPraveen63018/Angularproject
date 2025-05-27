# Stage 1: Build angular image
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npx ng build --configuration production

# Stage 2: Production
FROM nginx:alpine AS production
COPY --from=build /app/dist/angularproject /usr/share/nginx/html
EXPOSE 80
CMD ["nginx" "-g" "daemon off;"]
