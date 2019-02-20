FROM python:3.6
# this needs splitting up
WORKDIR /home
RUN mkdir -p /home/jupyter
WORKDIR /home/jupyter
COPY . /home/jupyter

# Configure Environment
ENV NBDIME_DIR /home/jupyter

RUN python -m venv env
RUN /bin/bash -c "source env/bin/activate; pip install nodeenv; nodeenv -p; pip install -e ."


EXPOSE 9000

CMD ["./env/bin/python3", "-m", "nbdime.webapp.nbdimeserver", "--port=9000", "--log-level=DEBUG", "--ip=0.0.0.0"]