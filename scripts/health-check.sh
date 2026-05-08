#!/bin/bash

curl -f http://localhost:3000

if [ $? -eq 0 ]; then
    echo "Application is healthy"
else
    echo "Application is down"
    exit 1
fi