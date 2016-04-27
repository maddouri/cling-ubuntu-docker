#!/usr/bin/env bash
set -eux

# USAGE: $0 <function1> <function2> ...
# @see last lines of this file


# Cling Build Instructions: https://root.cern.ch/cling-build-instructions
# clone.sh                : https://github.com/karies/cling-all-in-one/blob/master/clone.sh


WORK_DIR="/root/cling-build"
SRC_DIR="${WORK_DIR}/src"
BUILD_DIR="${WORK_DIR}/build"

INSTALL_DIR="/opt/cling"
COMMIT_SHA1="/opt/cling/CLING_COMMIT_SHA1"


function initialize() {
    mkdir -p "${WORK_DIR}"
}

function get_dependencies() {
    apt-get -qq  update
    apt-get -qqy install build-essential git cmake python
}

function clone_fast() {  # clone <repo_name> <branch> <dir>
    git clone --depth 1 "http://root.cern.ch/git/${1}.git" --branch "${2}" "${3}" >/dev/null
}

function get_sources() {
    clone_fast llvm  cling-patches "${SRC_DIR}"
    clone_fast clang cling-patches "${SRC_DIR}/tools/clang"
    clone_fast cling master        "${SRC_DIR}/tools/cling"
}

function configure_build() {
    mkdir -p "${BUILD_DIR}"
    cd "${BUILD_DIR}"
    cmake -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" -DPYTHON_EXECUTABLE=$(which python) "${SRC_DIR}"
}

function sub_build_1() {
    cd "${BUILD_DIR}"
    make --jobs=$(nproc) llvm-lto
}

function sub_build_2() {
    cd "${BUILD_DIR}"
    make --jobs=$(nproc) install
}

function build_all() {
    cd "${BUILD_DIR}"
    make --jobs=$(nproc) install
}

function write_cling_sha1() {
    cd "${SRC_DIR}/tools/cling"
    git rev-parse HEAD  >"${COMMIT_SHA1}"
}

function cleanup() {
    rm -rf "${WORK_DIR}"
}


function main() {
    initialize

    get_dependencies
    get_sources

    configure_build

    sub_build_1
    sub_build_2

    write_cling_sha1

    cleanup
}

# execute the given args (should be a function name, @see USAGE)
for f in "$@" ; do
    ${f} || { >&2 echo "$(readlink -f $0) [$@] failed at [${f}]" && exit 1; }
done
