# Vagrant based docker host

## Why would you want to do this???

This is a stopgap solution for testing docker. I have tried to start working with docker, but stopped every time because it broke my virtual machines. This may have been because I am doing something wrong, but this is my solution: getting docker to run inside a virtual machine orchestrated in a similar way using vagrant.  

I started using [vargant with php](https://github.com/JoSSte/BasicLamp) because I had some projects that needed modsecurity because i was running on a very restricted hosting environment - but that broke a lot of my other projects.  

I could probably have used other images - minishift came into mind, I am a big fan of openshift, but for learning the gritty basics, I found it relevant to start from the bottom.

To start off, this is JUST docker. no [helm](https://helm.sh/), no [kubernetes](https://kubernetes.io/), just the basics to see if i can transition my vms to docker images instead. 

I also created docker images for Jenkins to use as build slaves
* [java 8](https://github.com/JoSSte/java-docker-build-slave) 
* [php 8.1](https://github.com/JoSSte/php-docker-build-slave/releases/tag/v8)
* [php 7.4](https://github.com/JoSSte/php-docker-build-slave/releases/tag/v7)

## Usage
* Install vagrant
* Install docker cli
* Start up the image `vagrant up`
* Set the environment variable **DOCKER_HOST** to `tcp://127.0.0.1:4243`

## Links
* https://docs.docker.com/engine/install/ubuntu/
* https://docs.docker.com/engine/install/linux-postinstall/
* https://www.howtogeek.com/devops/how-and-why-to-use-a-remote-docker-host/


