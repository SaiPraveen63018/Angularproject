FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ..
RUN npm run build 

# Stage 2: Production
FROM build AS final
WORKDIR /app
COPY --from=build /app/build ./build
COPY package*.json ./
RUN npm install --production
EXPOSE 80
CMD ["npm", "start"]
