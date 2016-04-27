#!/usr/bin/env bash
set -eux


WORK_DIR="/root/cling-build"
SRC_DIR="${WORK_DIR}/src"
BUILD_DIR="${WORK_DIR}/build"

INSTALL_DIR="/opt/cling"
COMMIT_SHA1="/opt/cling/CLING_COMMIT_SHA1"


function build() {
    cd "${BUILD_DIR}"

    make --jobs=$(nproc) install

    cd "${SRC_DIR}/tools/cling"
    git rev-parse HEAD  >"${COMMIT_SHA1}"
}

function main() {
    build

    rm -rf "${WORK_DIR}"
}


main