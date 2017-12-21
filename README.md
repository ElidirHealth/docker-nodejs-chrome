# README

A [Docker](https://www.docker.com/) container with

- node.js 9.x
- chrome 
- grunt

XVFB removed as can now run chrome headless

# To Run

    $ docker run -it --rm -v $(pwd):/src -w /src -e NODE_ENV=CI elidirhealth/nodejs-karma npm -v
