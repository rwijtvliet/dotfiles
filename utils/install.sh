#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install npm snapd

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
    info "Installing core utils"
    brew install coreutils
    PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" # also in .bashrc
    info "Installing java"
    brew install java
    brew install openjdk
    todo "installed java - probably won't work anyway. Try 'java -version'. If error: install manually from oracle."
    info "Installing other packages"
    brew install npm
    brew install wget
    brew install nodejs
    ;;
    
  * )
    ;;
esac
