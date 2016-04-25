# Docker Build for Cling (C++ Interpreter)

[![](https://img.shields.io/badge/Github-maddouri%2Fcling--ubuntu--docker-brightgreen.svg?style=flat-square)](https://github.com/maddouri/cling-ubuntu-docker)
[![](https://img.shields.io/badge/Docker%20Hub-maddouri%2Fcling--ubuntu--docker-blue.svg?style=flat-square)](https://hub.docker.com/r/maddouri/cling-ubuntu-docker)

[![License](https://img.shields.io/github/license/maddouri/cling-ubuntu-docker.svg?style=flat-square)](LICENSE)

* Dockerized build of CERN's [Cling](https://root.cern.ch/cling).
* Based on Ubuntu 14.04. (can be changed in the [`Dockerfile`](./Dockerfile))

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Usage](#usage)
  - [Get the Image from Docker Hub](#get-the-image-from-docker-hub)
  - [Build It Yourself](#build-it-yourself)
- [Notes](#notes)
  - [Defining Aliases](#defining-aliases)
  - [Accessing the Host's File System](#accessing-the-hosts-file-system)
  - [Using Pipes](#using-pipes)
  - [Run Bash in the Container](#run-bash-in-the-container)
  - [Why ?](#why-)
  - [Which Version of Cling is Available in the Docker Image ?](#which-version-of-cling-is-available-in-the-docker-image-)
  - [Automated Builds](#automated-builds)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Usage

1. [Install docker](https://docs.docker.com/engine/installation/)
2. Get the image from Docker Hub or build it yourself
3. Use it like any other docker image


### Get the Image from Docker Hub

```bash
# get the build from docker hub
docker pull maddouri/cling-ubuntu-docker
# run it ! (the entry point is cling)
docker run -it maddouri/cling-ubuntu-docker
```

### Build It Yourself

```bash
# get the Dockerfile
git clone https://github.com/maddouri/cling-ubuntu-docker.git
cd cling-ubuntu-docker
# depending on your machine, this might take a while to finish building
docker build -t my_cling_image .
# run it ! (the entry point is cling)
docker run -it my_cling_image
```

## Notes

### Defining Aliases

```bash
alias cling='docker run -it maddouri/cling-ubuntu-docker'
```

### Accessing the Host's File System

As with any other Docker images, you can access your file system from the container by attaching volumes to it:

Syntax:

```bash
docker run -v /path/to/host/folder:/path/to/container/folder -it maddouri/cling-ubuntu-docker
```

Usage example:

```bash
$ ls /media/data/myCode
func.cpp

$ cat func.cpp
#include <iostream>
void sayHi() {
    std::cout << "Hello Dockerized Cling !" << std::endl;
}

$ docker run -v /media/data/myCode:/code -it maddouri/cling-ubuntu-docker
****************** CLING ******************
* Type C++ code and press enter to run it *
*             Type .q to exit             *
*******************************************
[cling]$ .L /code/func.cpp
[cling]$ sayHi()
Hello Dockerized Cling !
[cling]$ .q
$ # back to the host machine
```

### Using Pipes

```bash
# NB: use "-i" instead of "-it" when piping
echo -e '#include <iostream>\n std::cout <<  "Hello Dockerized Cling !" << std::endl;' | docker run -i maddouri/cling-ubuntu-docker
```

### Run Bash in the Container

```bash
# use bash as the new entry point
docker run -it --entrypoint=/bin/bash maddouri/cling-ubuntu-docker
```

### Why ?

Due to [an issue](https://github.com/vgvassilev/cling/issues/80), I couldn't get a precompiled version of cling for my Ubuntu 16.04 machine, neither did the current sources compile on my platform. (GCC 5 not supported)

### Which Version of Cling is Available in the Docker Image ?

When building an image, [`build-cling.sh`](./build-cling.sh) clones the latest commit available from [CERN's repository](https://root.cern.ch/gitweb/?p=cling.git;a=shortlog).

The exact commit SHA1 can be found in the `${CLING_COMMIT_SHA1}` file:

```bash
docker run -it --entrypoint=/bin/bash maddouri/cling-ubuntu-docker
cat ${CLING_COMMIT_SHA1}
```

### Automated Builds

After trying both Docker Hub's "Automated Builds" and Travis CI, it turns out that the images can't be built using those services -- in both cases, the build requires more time than the allowed amount.

For this reason, I will be pushing _non-automated builds_ to [Docker Hub](https://hub.docker.com/r/maddouri/cling-ubuntu-docker). (until I figure out a better solution)

## License

The content of the Github repository is available under the 3-Clause BSD license.

However, cling, llvm and clang (i.e. in the built docker image) have [different licenses](https://root.cern.ch/cling).

[IANAL](https://en.wikipedia.org/wiki/IANAL), so if the content of this repository does not comply with a given license, please contact me or [create a Github issue](https://github.com/maddouri/cling-ubuntu-docker/issues) in order to fix that :)
