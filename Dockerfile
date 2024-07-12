FROM node:lts-alpine AS build

WORKDIR /usr/src/app

COPY package.json /usr/src/app
COPY package-lock.json /usr/src/app
RUN npm install

COPY . /usr/src/app
RUN npm run build

FROM nginx:stable-alpine AS production
COPY nginx.conf /etc/nginx/nginx.conf
#COPY minipaint.conf /etc/nginx/conf.d/minipaint.conf

COPY --from=build /usr/src/app/dist /usr/share/nginx/html/dist
COPY --from=build /usr/src/app/index.html /usr/share/nginx/html
COPY --from=build /usr/src/app/images /usr/share/nginx/html/images

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
