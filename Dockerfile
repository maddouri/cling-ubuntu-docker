FROM maddouri/cling-ubuntu-docker_sub-build-2

MAINTAINER Mohamed-Yassine MADDOURI

#FROM ubuntu:14.04
#ADD ./build-cling.sh /root/build-cling.sh
#RUN /usr/bin/env bash /root/build-cling.sh main

ENV      CLING_PREFIX="/opt/cling"
     CLING_BIN_PREFIX="${CLING_PREFIX}/bin"
                CLING="${CLING_BIN_PREFIX}/cling"
    CLING_COMMIT_SHA1="${CLING_PREFIX}/CLING_COMMIT_SHA1"
                 PATH="${PATH}:${CLING_BIN_PREFIX}"

ENTRYPOINT "${CLING}"
