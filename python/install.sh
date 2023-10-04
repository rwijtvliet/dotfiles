#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    # raise error to alert user that this script is missing
    info "Installing app"
    sudo apt install python3
    pip3 install poetry
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
