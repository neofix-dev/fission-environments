ARG NODE_BASE_IMG

FROM node:${NODE_BASE_IMG}

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
COPY npm-wrapper.sh /usr/local/bin/npm-wrapper
RUN chmod +x /usr/local/bin/npm-wrapper
RUN npm-wrapper install && npm-wrapper cache clean --force
COPY server.js /usr/src/app/server.js

CMD [ "npm-wrapper", "start" ]

EXPOSE 8888