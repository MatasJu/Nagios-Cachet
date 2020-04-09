#!/bin/bash
SCRIPT_LOCATION = "$(pwd)"

mkdir tmp &&  cd tmp
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
