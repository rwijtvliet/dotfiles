#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app"
    sudo apt update
    sudo apt install chromium-browser
    sudo apt install firefox
    ;;

  "windows" )
    fail "to-do"
    exit 1
    ;;

  "macos" )
    info "Installing app"
    brew install --cask chromium
    brew install firefox
    ;;
    
  * )
    ;;
esac
