FROM python:3

RUN apt-get update && apt-get -y install curl && curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get -y install build-essential nodejs
COPY ./dist /app
WORKDIR /app
RUN pip install nbdime-1.0.5.dev0-py2.py3-none-any.whl

