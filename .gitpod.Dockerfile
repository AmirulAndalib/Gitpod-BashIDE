FROM fr3akyphantom/droid-builder:focal
#FROM gitpod/workspace-full-vnc:latest

COPY build.sh /home/build.sh

USER root
RUN bash /home/build.sh

RUN sudo apt update -qqy && sudo apt install -qy npm nodejs
RUN npm i -g bash-language-server

USER builder
