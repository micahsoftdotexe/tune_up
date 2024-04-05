FROM postgres:latest
RUN apt-get update
RUN apt-get install -y wget sudo pgloader
COPY ./instructions.load instructions.load