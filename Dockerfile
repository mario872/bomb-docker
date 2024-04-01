# syntax=docker/dockerfile:1

FROM python:3.11-slim-bullseye
LABEL maintainer="jamesaglynn10@gmail.com"
LABEL version="1.0"
LABEL description="The docker image for BOMB, Bob's Overcompensating Meteorological Bird"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -yq tzdata
RUN ln -fs /usr/share/zoneinfo/Australia/Sydney /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

ENV TZ="Australia/Sydney"

WORKDIR /home/bomb

COPY static /home/bomb-docker/static
COPY templates /home/bomb-docker/templates
COPY main.py /home/bomb-docker/main.py
COPY requirements.txt /home/bomb-docker/requirements.txt

RUN python3 -m pip install --upgrade -r /home/bomb-docker/requirements.txt

EXPOSE 80 443

CMD [ "python3", "/home/bomb-docker/main.py"]