#!/bin/bash

docker stop nodejs-container || true
docker rm nodejs-container || true

docker run -d \
  --name nodejs-container \
  -p 3000:3000 \
  previous-image