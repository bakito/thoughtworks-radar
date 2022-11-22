FROM node:lts-hydrogen as builder
ARG BASE_REVISION=master
WORKDIR /src
RUN git clone https://github.com/thoughtworks/build-your-own-radar.git

WORKDIR /src/build-your-own-radar

RUN git checkout ${BASE_REVISION}

RUN npm install
RUN npm run build:prod

RUN sed 's/listen 80;/listen 8080;\n  server_name radar;/g' /src/build-your-own-radar/default.template > /src/build-your-own-radar/default.conf

RUN mkdir -p  /src/build-your-own-radar/dist/files && \
    chown -R 1001:1001 /src/build-your-own-radar/dist/ /src/build-your-own-radar/default.conf

FROM bitnami/nginx:latest
RUN mkdir -p /bitnami/nginx/conf/vhosts

COPY --from=builder /src/build-your-own-radar/dist/ /opt/build-your-own-radar/
COPY --from=builder /src/build-your-own-radar/default.conf /opt/bitnami/nginx/conf/server_blocks/
