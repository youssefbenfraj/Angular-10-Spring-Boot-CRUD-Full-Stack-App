
#stage 1
FROM node:12.15 as node
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod

#stage 2
FROM nginx:alpine
COPY src/etc/nginx/conf.d/default.conf /etc/nginx/conf/default.conf
COPY --from=node /app/dist/angular-frontend /usr/share/nginx/html
