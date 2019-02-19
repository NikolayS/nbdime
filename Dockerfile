FROM python:3

RUN apt-get update && apt-get -y install curl && curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get -y install build-essential nodejs
COPY . /app
WORKDIR /app
RUN npm install -g tsc
RUN pip install .

