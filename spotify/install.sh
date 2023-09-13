#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    # Skip if irrelevant for this OS
    fail "to-do"
    exit 1
    ;;

  "windows" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
    ;;

  "macos" )
    info "Installing app"
    brew install --cask spotify
    ;;
    
  * )
    ;;
esac
