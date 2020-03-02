FROM python:3.9.0a4-buster

WORKDIR /trittico

RUN apt-get update

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .