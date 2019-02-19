FROM python:3.7-alpine3.9

RUN apk add --update nodejs nodejs-npm build-base
COPY . /app
WORKDIR /app
RUN npm install
RUN pip install .

