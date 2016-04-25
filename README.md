# Docker Build for Cling (C++ Interpreter)

* Based on Ubuntu (can be changed to any other _compatible_ OS/version in the [`Dockerfile`](./Dockerfile))
* Uses CERN's [`clone.sh`](https://github.com/karies/cling-all-in-one/blob/master/clone.sh) (cf. [Cling Build Instructions](https://root.cern.ch/cling-build-instructions))

## Usage

You can either get the image from Docker Hub or build it yourself.

### The Easy Way

```bash
# get the build from docker hub
docker pull maddouri/cling-ubuntu-docker
# run it !
docker run -ti maddouri/cling-ubuntu-docker cling
```

### Build It Yourself

```bash
# get the Dockerfile
git clone https://github.com/maddouri/cling-ubuntu-docker.git
cd cling-ubuntu-docker
# depending on your machine, this might take a while to finish building
docker build -t my_cling_image .
# run it !
docker run -ti my_cling_image cling
```

## Notes

### Defining Aliases

```bash
alias cling='docker run -ti maddouri/cling-ubuntu-docker cling'
```

### Working with Files

As with any other Docker images, you can access your file system from the container by attaching volumes to it:

```bash
# syntax
docker run -v /path/to/host/folder:/path/to/container/folder -ti maddouri/cling-ubuntu-docker cling
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

$ docker run -v /media/data/myCode:/code -ti maddouri/cling-ubuntu-docker cling
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
