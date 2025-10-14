#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install virtualbox virtualbox-guest-additions-iso virtualbox-ext-pack
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
