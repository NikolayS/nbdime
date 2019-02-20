FROM python:3.6
# this needs splitting up
WORKDIR /home
RUN mkdir -p /home/jupyter
WORKDIR /home/jupyter
COPY . /home/jupyter

# Configure Environment
ENV NBDIME_DIR /home/jupyter

RUN python -m venv env
RUN source env/bin/activate
RUN pip install nodeenv
RUN nodeenv -p
RUN npm install -g lerna
RUN pip install .


EXPOSE 9000

CMD ["./env/bin/python3", "-m", "nbdime.webapp.nbdimeserver", "--port=9000", "--log-level=DEBUG", "--ip=0.0.0.0"]