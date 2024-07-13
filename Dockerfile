FROM node:lts-alpine AS build

WORKDIR /usr/src/app

COPY package.json /usr/src/app
COPY package-lock.json /usr/src/app
RUN npm install

COPY . /usr/src/app
RUN npm run build

FROM caddy:alpine AS production
COPY Caddyfile /etc/caddy/Caddyfile

RUN mkdir -p /usr/share/caddy/html
COPY --from=build /usr/src/app/dist /usr/share/caddy/html/dist
COPY --from=build /usr/src/app/index.html /usr/share/caddy/html
COPY --from=build /usr/src/app/images /usr/share/caddy/html/images

EXPOSE 80
