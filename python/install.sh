#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app" 
    sudo apt install python3 python3-pip python-is-python3
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
