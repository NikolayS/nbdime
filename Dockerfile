FROM python:3

RUN apt update && apt install nodejs npm
COPY . /app
WORKDIR /app
RUN npm install -g tsc
RUN pip install .

