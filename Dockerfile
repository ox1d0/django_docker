# pull official base image
FROM python:3.8

# accept arguments
ARG PIP_REQUIREMENTS=production.txt

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip setuptools

# create user for the Django project
RUN useradd -ms /bin/bash ox1d0

# set current user
USER ox1d0

# set work directory
WORKDIR /home/ox1d0

# create and activate virtual environment
RUN python3 -m venv env

# copy and install pip requirements
COPY --chown=ox1d0 ./src/ox1d0/requirements /home/ox1d0/requirements/
RUN ./env/bin/pip3 install -r /home/ox1d0/requirements/${PIP_REQUIREMENTS}

# copy Django project files
COPY --chown=ox1d0 ./src/ox1d0 /home/ox1d0/
