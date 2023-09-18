#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install inkscape
    ;;

  "windows" )
    todo 
    ;;

  "macos" )
    brew install --cask inkscape
    ;;
    
  * )
    ;;
esac
