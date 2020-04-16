FROM ubuntu:latest
RUN apt-get update && \
    apt-get -y install sudo curl && \
    useradd -ms /bin/bash ubuntu && \
    echo "ubuntu:ubuntu" | chpasswd && \
    adduser ubuntu sudo
USER ubuntu
WORKDIR /home/ubuntu

