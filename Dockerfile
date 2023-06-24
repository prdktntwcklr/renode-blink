FROM ubuntu:22.04

# update package information and install required packages
RUN apt-get update && \
    apt-get install -y gcc-arm-none-eabi git make wget && \
    apt-get autoremove -y && \
    apt-get clean

# set up a directory for development
WORKDIR /home/app
