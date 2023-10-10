#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
<<<<<<< HEAD
    info "Installing app" 
    sudo apt install python3 python3-pip
=======
    # raise error to alert user that this script is missing
    info "Installing app"
    sudo apt install python3 python3-pip
    pip3 install poetry
>>>>>>> cb0f0b86a3b3191edc6def94d08eedc88d8be031
    ;;

  "windows" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
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
