FROM node:12-alpine
MAINTAINER info@vizzuality.com

ENV NAME docswagger
ENV USER docswagger

RUN apk update && apk upgrade && \
    apk add --no-cache --update bash git openssh

RUN addgroup $USER && adduser -s /bin/bash -D -G $USER $USER

RUN yarn global add grunt-cli bunyan

RUN mkdir -p /opt/$NAME
COPY package.json /opt/$NAME/package.json
COPY yarn.lock /opt/$NAME/yarn.lock
RUN cd /opt/$NAME && yarn

COPY entrypoint.sh /opt/$NAME/entrypoint.sh

WORKDIR /opt/$NAME

COPY ./index.js /opt/$NAME/index.js
RUN chown -R $USER:$USER /opt/$NAME

# Tell Docker we are going to use this ports
EXPOSE 3500
USER $USER

ENTRYPOINT ["./entrypoint.sh"]
