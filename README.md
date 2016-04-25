# Docker Build for Cling (C++ Interpreter)

[![](https://img.shields.io/badge/Github-maddouri%2Fcling--ubuntu--docker-brightgreen.svg?style=flat-square)](https://github.com/maddouri/cling-ubuntu-docker)
[![](https://img.shields.io/badge/Docker%20Hub-maddouri%2Fcling--ubuntu--docker-blue.svg?style=flat-square)](https://hub.docker.com/r/maddouri/cling-ubuntu-docker)

[![Build Status](https://travis-ci.org/maddouri/cling-ubuntu-docker.svg?branch=develop)](https://travis-ci.org/maddouri/cling-ubuntu-docker)

A dockerized build of CERN's [Cling](https://root.cern.ch/cling).

## Usage

You can either get the image from Docker Hub or build it yourself.

### The Easy Way

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
docker run -it my_cling_image cling
```

## Notes

### Defining Aliases

```bash
alias cling='docker run -it maddouri/cling-ubuntu-docker'
```

### Working with Files

#### Acessing the File System

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

#### Piping

```bash
# NB: use "-i" instead of "-it" when piping
echo -e '#include <iostream>\n std::cout <<  "Hello Dockerized Cling !" << std::endl;' | docker run -i maddouri/cling-ubuntu-docker
```
