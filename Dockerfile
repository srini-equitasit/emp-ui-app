FROM node:14-alpine as build-step
RUN mkdir -p /app

WORKDIR /app
COPY . /app

#RUN pwd
#RUN ls -l

#RUN npm install --loglevel verbose
RUN npm install

RUN npm run build --prod


## stage 2
FROM nginx:1.13.12-alpine
COPY --from=build-step /app/dist/emp-ui-app /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
COPY backend-proxy.conf.template /etc/nginx/conf.d/backend-proxy.conf.template
#CMD ["envsubst", " < /etc/nginx/conf.d/backend-proxy.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
#ENTRYPOINT /bin/bash -c "envsubst < /etc/nginx/conf.d/backend-proxy.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
EXPOSE 80



#EXPOSE 4200 49153
#EXPOSE 4200
#CMD npm start

#docker run -it 337901474843.dkr.ecr.us-east-1.amazonaws.com/equitas-it:emp-ui-app sh
