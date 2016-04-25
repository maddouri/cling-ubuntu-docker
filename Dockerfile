FROM ubuntu:14.04

# get dependencies
# build cling
# clean up
RUN    apt-get update                        \
    && apt-get -qqy install build-essential  \
                            git              \
                            cmake            \
                            wget             \
                            python           \
    \
    && cd && mkdir cling-build && cd cling-build  \
    \
    && wget -qO- https://raw.githubusercontent.com/karies/cling-all-in-one/master/clone.sh  \
    |  sed 's/git\s\+clone\s\+http:\/\/root.cern.ch\/git.\+/git clone --depth=1 http:\/\/root.cern.ch\/git\/${1}.git --branch=$2 $where > \/dev\/null || exit 1/'  \
    |  sed '/cd.\+git\s\+checkout/d'  \
    >  clone-fast.sh                  \
    && chmod +x ./clone-fast.sh       \
    && ./clone-fast.sh                \
    \
    && echo $(cd src && git rev-parse HEAD) > inst/CLING_COMMIT_SHA1 \
    \
    && mv inst /opt/cling && cd .. && rm -rf cling-build

ENV PATH              "$PATH:/opt/cling/bin"
ENV CLING             "/opt/cling/bin/cling"
ENV CLING_COMMIT_SHA1 "/opt/cling/CLING_COMMIT_SHA1"
