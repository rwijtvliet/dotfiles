#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app"
    sudo apt install chromium-browser
    ;;

  "windows" )
    fail "to-do"
    exit 1
    ;;

  "macos" )
    info "Installing app"
    brew install --cask chromium
    ;;
    
  * )
    ;;
esac
