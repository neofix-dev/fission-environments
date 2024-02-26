ARG NODE_BASE_IMG
ARG BUILDER_IMAGE=fission/builder:latest

FROM ${BUILDER_IMAGE}

FROM node:${NODE_BASE_IMG}
RUN apk add --no-cache findutils

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

COPY --from=0 /builder /builder
RUN npm install -g typescript@5.0.4 @swc/cli @swc/core
ADD build.sh /usr/local/bin/build
ADD npm-wrapper.sh /usr/local/bin/npm-wrapper
RUN chmod +x /usr/local/bin/npm-wrapper
RUN chmod +x /usr/local/bin/build
