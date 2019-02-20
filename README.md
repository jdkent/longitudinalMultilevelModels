# Longitudinal Multilevel Models

This repository contains some SAS->R code translations from
Dr. Lesa Hoffman's [PSQF7375](http://www.lesahoffman.com/PSQF7375_Longitudinal/index.html) course.

## How to run this code

### prerequisites

1. install docker
    - [for mac](https://docs.docker.com/docker-for-mac/install/)
    - [for windows](https://docs.docker.com/docker-for-windows/install/)
    - [for linux (find your distro)](https://docs.docker.com/install/)

1. make account on [dockerhub](https://hub.docker.com/)

1. install git
    - [git for windows](https://git-scm.com/download)
    - most mac and linux machines should come with git installed, otherwise use the link above.

Docker is a helpful solution for the "[works on my machine](https://hackernoon.com/it-works-on-my-machine-f7a1e3d90c63)" dilemma and [dependency hell](https://en.wikipedia.org/wiki/Dependency_hell).

dockerhub is a good solution for storing the docker images.
Making an account may be necessary to download other people's docker images

Finally, git/github is the place where we can safely version control all of our files.

### Steps

1. [Clone/Download the repository](https://help.github.com/articles/cloning-a-repository/)
    - `git clone https://github.com/jdkent/longitudinalMultilevelModels.git`

1. Open your terminal (or powershell) and navigate to the directory `longitudinalMultilevelModels`.

1. Once inside the directory, either build or pull the docker container.
    - build: `docker build -t lmm .`
    - pull: `docker pull jdkent/lmm`

1. Start the docker container:
    - `docker run --rm -p 127.0.0.1:8787:8787 -e DISABLE_AUTH=true -v ${PWD}:/home/rstudio/kitematic jdkent/lmm`
        - `jdkent/lmm` may be `lmm` if you built the image locally.

1. Open your favorite browser and place `127.0.0.1:8787` in the address bar.

1. Enjoy RStudio!