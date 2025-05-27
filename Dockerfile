# Stage 1: Build angular image
FROM node:16 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install 
RUN npm install -g @angular/cli@13
COPY . .
RUN ng build --configuration production

# Stage 2: Production
FROM nginx:alpine AS production
COPY --from=build /dist/angularproject /usr/share/nginx/html
EXPOSE 80
CMD ["nginx" "-g" "daemon off;"]
