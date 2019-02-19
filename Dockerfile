FROM python:3.7-alpine3.9

COPY . /app
WORKDIR /app
RUN pip install .

