#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app"
    sudo apt update
    sudo apt install gh
    info "Configuring app"
    gh auth login
    ;;

  "windows" )
    info "Installing app"
    scoop bucket add main
    scoop install main/gh
    info "Configuring app"
    gh auth login
    ;;

  "macos" )
    info "Installing app"
    brew install gh
    info "Configuring app"
    gh auth login
    ;;
    
  * )
    ;;
esac
