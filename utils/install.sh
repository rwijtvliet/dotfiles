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
    info "Installing gnu versions"
    brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
    PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" # also in .bashrc
    info "Installing java"
    brew install java
    brew install openjdk
    todo "installed java - probably won't work anyway. "
    brew install npm
    brew install wget
    brew install nodejs
    ;;
    
  * )
    ;;
esac
