FROM python:3.7.4-slim-buster AS build-stage

RUN apt-get update && apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_11.x | bash - && apt-get install -y nodejs
WORKDIR /home
RUN mkdir -p /home/jupyter && mkdir -p /home/jupyter/nbdime \
    && mkdir -p /home/jupyter/packages && mkdir -p /home/jupyter/packages/labextension \
    && mkdir -p /home/jupyter/packages/nbdime && mkdir -p /home/jupyter/packages/webapp
WORKDIR /home/jupyter

# these are least likely to change, copy them first and do the install
COPY packages/labextension/package.json packages/labextension/tsconfig.json packages/labextension/
COPY packages/nbdime/package.json packages/nbdime/tsconfig.json packages/nbdime/
COPY packages/webapp/package.json packages/webapp/tsconfig.json packages/webapp/
COPY package.json tsconfig.json tsconfig_base.json lerna.json package-lock.json /home/jupyter/
RUN npm install && cd packages/labextension && npm install && cd ../nbdime && npm install && cd ../webapp && npm install

# copy the python stuff, also unlikely to change
COPY ./jupyter-config /home/jupyter/jupyter-config
COPY ./nbdime /home/jupyter/nbdime
COPY setup.py MANIFEST.in setup.cfg setupbase.py LICENSE.md README.md /home/jupyter/

# copy the remainder of the js code
COPY ./packages /home/jupyter/packages
RUN npm run build


# not sure this does anything, pinched from another dockerfile
ENV NBDIME_DIR /home/jupyter
ENV JUPYTER_CONFIG_DIR /home/jupyter/jupyter-config

# finally, install it all (also does npm run build using lerna)
RUN python -m venv /home/jupyter/venv
RUN venv/bin/pip install .


# Runtime image, much smaller:
FROM python:3.7.4-slim-buster AS runtime-stage
COPY --from=build-stage /home/jupyter/venv /home/jupyter/venv
# Active the virtualenv
ENV PATH=/home/jupyter/venv/bin:$PATH

EXPOSE 9000

CMD ["python", "-m", "nbdime.webapp.nbdimeserver", "--port=9000", "--log-level=DEBUG", "--ip=0.0.0.0"]
