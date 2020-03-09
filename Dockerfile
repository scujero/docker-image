FROM python:3.9.0a4-buster

RUN apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

FROM node:13.8.0-buster

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main">> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq --no-install-recommends google-chrome-stable && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /sashimi-utils

COPY package.json /sashimi-utils/package.json

RUN npm install -g npm@latest
RUN npm install -g @angular/cli@latest

RUN npm install

