FROM python:3

RUN apt-get install nodejs nodejs-npm
COPY . /app
WORKDIR /app
RUN npm install -g tsc
RUN pip install .

