FROM maddouri/cling-ubuntu-docker_auto:sub-build-1

MAINTAINER Mohamed-Yassine MADDOURI

RUN /usr/bin/env bash /root/build-cling.sh sub_build_1
