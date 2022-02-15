FROM alpine:latest

ENV NODE_ENV prod

RUN echo "http://mirrors.aliyun.com/alpine/edge/main/" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/edge/community/" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache --update nodejs nodejs-npm \
    && npm config set registry https://registry.npmmirror.com

WORKDIR /home/app

COPY package.json /home/app/

RUN npm install --prod

COPY . /home/app

EXPOSE 9090

CMD [ "node", "dispatch.js" ]