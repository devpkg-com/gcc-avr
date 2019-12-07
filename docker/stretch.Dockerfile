FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

COPY apt.conf /etc/apt/apt.conf.d/install

RUN apt-get update

RUN echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
RUN echo "localepurge localepurge/nopurge multiselect en,en_US.UTF-8" | debconf-set-selections
RUN apt-get install -y localepurge
RUN dpkg-reconfigure localepurge
RUN localepurge

RUN apt-get install -y libgmp-dev
RUN apt-get install -y libmpfr-dev
RUN apt-get install -y libmpc-dev
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y tar
RUN apt-get install -y build-essential
RUN apt-get install -y binutils-avr
RUN apt-get install -y libisl-dev
RUN apt-get install -y debhelper
RUN apt-get install -y wget
RUN apt-get install -y ca-certificates
