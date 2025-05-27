FROM node:18-alpine AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build 

# Stage 2: Serve with nginx
FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy static files to nginx
COPY --from=build /app /usr/share/nginx/html

# Copy custom nginx config (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
🔁 If You’re Not Using a Build Step:
If your AngularJS project is already built (i.e., just HTML, JS, and CSS in a folder), you can simplify it:

Dockerfile
Copy
Edit
FROM nginx:alpine

COPY . /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
