FROM ubuntu:14.04

MAINTAINER Mohamed-Yassine MADDOURI

ADD ./build-cling.sh /root/build-cling.sh

RUN /usr/bin/env bash /root/build-cling.sh main

ENV         CLING_DIR="/opt/cling"                    \
                CLING="/opt/cling/bin/cling"          \
    CLING_COMMIT_SHA1="/opt/cling/CLING_COMMIT_SHA1"  \
                 PATH="$PATH:/opt/cling/bin"

ENTRYPOINT "/opt/cling/bin/cling"
