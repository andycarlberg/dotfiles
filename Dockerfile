FROM ubuntu

RUN apt-get update --fix-missing && \
    mkdir -p /root/.dotfiles

ENTRYPOINT /bin/bash
