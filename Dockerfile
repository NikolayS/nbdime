FROM python:3.6
# this needs splitting up
COPY . /app
WORKDIR /app

# Configure Environment
ENV NBDIME_DIR /home/jupyter/nbdime
ENV NB_USER nbdime
ENV NB_UID 1000

# Create nbdime user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p $NBDIME_DIR && \
    chown $NB_USER $NBDIME_DIR

RUN python -m venv env
RUN /bin/bash -c "source env/bin/activate; pip install nodeenv; nodeenv -p; pip install ."

#USER $NB_USER
EXPOSE 9000

CMD ["./env/bin/python3", "-m", "nbdime.webapp.nbdimeserver", "--port=9000", "--log-level=DEBUG", "--ip=0.0.0.0"]