FROM ubuntu

RUN apt-get update -y
RUN apt-get install -y curl
RUN apt-get install -y tar
RUN apt-get install -y mkisofs
RUN apt-get install -y syslinux

RUN mkdir /work
WORKDIR /work

COPY . /work

ENV SYSLINUX_VERSION 6.02
ENV COREOS_VERSION master
ENV BOOT_ENV bios
ENV SSH_PUBKEY_PATH ./id_rsa.pub

RUN ./makeiso.sh && mv CoreOS.${COREOS_VERSION}.iso /CoreOS.iso
