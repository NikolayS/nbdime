FROM python:3.7-alpine3.9

RUN apk add --update nodejs nodejs-npm
COPY . /app
WORKDIR /app
RUN pip install .

