#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    fail "to-do"
    ;;

  "windows" )
    info "Installing app"
    scoop bucket add main
    scoop install main/gh
    ;;

  "macos" )
    info "Installing app"
    brew install gh
    ;;
    
  * )
    ;;
esac
