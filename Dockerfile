FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ..
RUN npm run build 

# Stage 2: Production
FROM builder AS final
WORKDIR /app
COPY --from=builder /app/build ./build
COPY package*.json ./
RUN npm install --production
EXPOSE 80
CMD ["npm", "start"]
