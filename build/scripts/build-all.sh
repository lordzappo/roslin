#!/bin/bash -e

./build-images.sh
./build-cwl.sh
./push-to-docker-hub.sh
