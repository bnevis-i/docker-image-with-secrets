FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates npm

WORKDIR /example

COPY package.json .
ADD http://httpuser:httppassword@microsoft.com/robots.txt .

# NPM_CONFIG_PASSWORD will be encoded into the dockerfile history when passed on docker build line in Makefile
ARG NPM_CONFIG_USERNAME
ARG NPM_CONFIG_PASSWORD

RUN git clone -b empty https://githubuser:githubpassword_cleaned@github.com/bnevis-i/docker-image-with-secrets.git docker-image-with-secrets-cleaned && rm -fr docker-image-with-secrets-cleaned/.git
RUN git clone -b empty https://githubuser:githubpassword_dirty@github.com/bnevis-i/docker-image-with-secrets.git docker-image-with-secrets-dirty
RUN env 
RUN npm install
