FROM ubuntu

RUN apt-get update -y
RUN apt-get install -y curl
RUN apt-get install -y tar
RUN apt-get install -y mkisofs
RUN apt-get install -y syslinux

RUN mkdir /work
WORKDIR /work

COPY ./id_rsa.pub /work/id_rsa.pub

COPY . /work
CMD ["./makeiso.sh"]
