FROM ubuntu:latest
RUN useradd -ms /bin/bash ubuntu
USER ubuntu
WORKDIR /home/ubuntu

