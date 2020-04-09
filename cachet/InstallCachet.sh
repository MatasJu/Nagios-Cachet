#!/bin/bash
SCRIPT_LOCATION="$(pwd)"

mkdir tmp &&  cd tmp
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh


sudo apt install -y libffi-dev libssl-dev
sudo apt install -y python3 python3-pip
sudo pip3 install docker-compose