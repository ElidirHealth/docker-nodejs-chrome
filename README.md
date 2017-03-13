# README

A [Docker](https://www.docker.com/) container with

- node.js 5.x
- chrome for karma headless testing

# To Run

    $ docker run -it --rm -v $(pwd):/src -w /src -e NODE_ENV=CI emmenko/nodejs-karma npm -v
