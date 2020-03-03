FROM python:3.9.0a4-buster

WORKDIR /trittico

RUN apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

FROM node:13.8.0-buster

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main">> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq --no-install-recommends google-chrome-stable && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /sashimi

ENV PATH /sashimi/node_modules/.bin:$PATH

COPY package.json /sashimi/package.json

RUN npm install -g npm@latest
RUN npm install
RUN npm install -g @angular/cli@latest
