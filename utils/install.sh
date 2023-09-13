#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install npm

    sudo apt update
    sudo apt upgrade
    ;;

  "windows" )
    scoop install wget   
    scoop install npm
    scoop install nodejs

    scoop update *
    ;;

  "macos" )
    brew install coreutils
    PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" # also in .bashrc
    brew install npm
    brew install wget
    brew install nodejs
    ;;
    
  * )
    ;;
esac
