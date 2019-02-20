FROM python:3.6


WORKDIR /home
RUN mkdir -p /home/jupyter && mkdir -p /home/jupyter/nbdime \
    && mkdir -p /home/jupyter/packages && mkdir -p /home/jupyter/packages/labextension \
    && mkdir -p /home/jupyter/packages/nbdime && mkdir -p /home/jupyter/packages/webapp
WORKDIR /home/jupyter
COPY packages/labextension/package.json packages/labextension
COPY packages/nbdime/package.json packages/nbdime
COPY packages/webapp/package.json packages/webapp
COPY ./nbdime /home/jupyter/nbdime
COPY setup.py MANIFEST.in setup.cfg setupbase.py tsconfig.json tsconfig_base.json lerna.json package.json package-lock.json /home/jupyter/
COPY scripts/ /home/jupyter/scripts
COPY ./packages /home/jupyter/packages


# Configure Environment
ENV NBDIME_DIR /home/jupyter

RUN python -m venv env

RUN bash scripts/install-npm.sh
RUN bash scripts/install-pip.sh

EXPOSE 9000

CMD ["./env/bin/python3", "-m", "nbdime.webapp.nbdimeserver", "--port=9000", "--log-level=DEBUG", "--ip=0.0.0.0"]