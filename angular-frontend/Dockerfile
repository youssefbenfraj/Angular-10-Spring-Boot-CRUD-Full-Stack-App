
#stage 1
FROM node:12.15 as node
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

#stage 2
FROM nginx:alpine
COPY --from=node /app/dist/angular8-springboot-client /usr/share/nginx/html
