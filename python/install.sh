#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app"
    echo "deb https://ppa.launchpadcontent.net/deadsnakes/ppa/ubuntu/ jammy main" | sudo tee /etc/apt/sources.list.d/deadsnakes-ubuntu-ppa-lunar.list
    sudo apt update
    sudo apt install python3 python3-pip python-is-python3 python3.12
    pip3 install poetry
    ;;

  "windows" )
    scoop install python
    pip install poetry
    ;;

  "macos" )
    info "Installing app"
    brew install python
    # The aliases python=python3 and pip=pip3 should already be available. But just in case we use pip3 here
    pip3 install poetry
    ;;
    
  * )
    ;;
esac
