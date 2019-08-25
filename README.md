# fixer_io_lucky

## Lucky and Crystal

### Setting up the project

1. [Install required dependencies](http://luckyframework.org/guides/installing.html#install-required-dependencies)
2. Run `script/setup`
3. Run `lucky dev` to start the app

### Learning Lucky

Lucky uses the [Crystal](https://crystal-lang.org) programming language. You can learn about Lucky from the [Lucky Guides](http://luckyframework.org/guides).

## Docker

### Build in Docker

Base image is created from this repo [nulty/docker-lucky](https://github.com/nulty/docker-lucky)
`docker build --build-arg DB_PASSWORD=YOUR_PASSWORD -t YOUR_DOCKER_TAG .`


### Run in Docker
  Running the app from a docker container is something I'll look into in the future

### CircleCI

Configuration is found in `.circleci/config.yml`

We use a custom docker image `iainmcnulty/lucky` which is based off `crystallang/crystal:0.30.1` but which has been modified to add `node 10.16`, `postgresql-9.6` and also installed `yarn`. We need yarn to build the assets in the lucky application.

To make changes to the ci config, you will probably want to install the circleci commandline tool which allows you to build the container and run the config locally.

`circleci build .`

## TODO
  - Use docker compose to attach an external postgres container
  - Get the app running in a container exposing ports to the host
    - libevent 2.1 not available in the base image containter (Xenial) - upgrade
