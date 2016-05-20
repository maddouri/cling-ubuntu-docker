FROM maddouri/cling-ubuntu-docker_auto:sub-build-2

MAINTAINER Mohamed-Yassine MADDOURI

ENV         CLING_DIR="/opt/cling"                    \
                CLING="/opt/cling/bin/cling"          \
    CLING_COMMIT_SHA1="/opt/cling/CLING_COMMIT_SHA1"  \
                 PATH="$PATH:/opt/cling/bin"

ENTRYPOINT "/opt/cling/bin/cling"
