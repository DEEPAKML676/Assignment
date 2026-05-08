#!/bin/bash

docker pull deepakml2000/nodejs-app:latest

docker stop nodejs-container || true
docker rm nodejs-container || true

docker run -d \
  --name nodejs-container \
  -p 3000:3000 \
  deepakml2000/nodejs-app:latest