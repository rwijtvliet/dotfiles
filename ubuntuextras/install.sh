#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install -y ubuntu-restricted-extras
    ;;

  "windows" )
    skip
    ;;

  "macos" )
    skip
    ;;
    
  * )
    ;;
esac
