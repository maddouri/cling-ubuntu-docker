FROM ubuntu:14.04

MAINTAINER Mohamed-Yassine MADDOURI

ADD ./build-cling.sh /root/build-cling.sh

RUN /usr/bin/env bash /root/build-cling.sh  initialize        \
                                            get_dependencies  \
                                            get_sources       \
                                            configure_build   \
                                            sub_build_1
