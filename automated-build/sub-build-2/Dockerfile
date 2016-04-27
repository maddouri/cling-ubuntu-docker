FROM maddouri/cling-ubuntu-docker_sub-build-1

ADD ./build-2.sh /root/build-2.sh

RUN /usr/bin/env bash /root/build-2.sh

ENV PATH              "$PATH:/opt/cling/bin"
ENV CLING             "/opt/cling/bin/cling"
ENV CLING_COMMIT_SHA1 "/opt/cling/CLING_COMMIT_SHA1"

ENTRYPOINT "/opt/cling/bin/cling"