FROM ubuntu

RUN apt-get update -y
RUN apt-get install -y curl
RUN apt-get install -y tar
RUN apt-get install -y mkisofs
RUN apt-get install -y syslinux

RUN mkdir /work
WORKDIR /work

COPY . /work

ENV SSH_PUBKEY_PATH ./id_rsa.pub
ENV COREOS_VERSION master

RUN ./makeiso.sh && mv CoreOS.${COREOS_VERSION}.iso /CoreOS.iso
