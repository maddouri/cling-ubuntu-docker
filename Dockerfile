FROM ubuntu:14.04

# get dependencies
# build cling
# clean up
RUN    apt-get update                      \
    && apt-get install -y build-essential  \
                          m4               \
                          checkinstall     \
                          git              \
                          cmake            \
                          libxml2-dev      \
                          python           \
                          libz-dev         \
                          rsync            \
                          curl             \
                          wget             \
    \
    && cd && mkdir cling-build && cd cling-build  \
    \
    && wget https://raw.githubusercontent.com/karies/cling-all-in-one/master/clone.sh  \
    \
    && chmod +x ./clone.sh && ./clone.sh  \
    \
    && echo $(cd src && git rev-parse HEAD) > inst/CLING_COMMIT_SHA1 \
    \
    && mv inst /opt/cling && cd .. && rm -rf cling-build

ENV PATH              "$PATH:/opt/cling/bin"
ENV CLING             "/opt/cling/bin/cling"
ENV CLING_COMMIT_SHA1 "/opt/cling/CLING_COMMIT_SHA1"
