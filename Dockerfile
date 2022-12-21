FROM ubuntu:20.04
RUN apt-get update &&\
  apt-get install -y curl
RUN apt-get update && apt-get install -y gnupg
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn
# Not installing suggested or recommended dependencies
RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
# Preventing prompt errors during package installation
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y python3 \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /app
# COPY package*.json ./
COPY . .
# RUN yarn install
CMD ["node", "src/routes.js"]
EXPOSE 3000
