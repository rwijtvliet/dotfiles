#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app"
    sudo snap install p3x-onenote
    info "Adding to launcher"
    sudo cp /var/lib/snapd/desktop/applications/*.desktop /usr/share/applications/
    ;;

  "windows" )
    fail "to-do; or already installed?"
    exit 1
    ;;

  "macos" )
    fail "to-do; or already installed?"
    exit 1
    ;;
    
  * )
    ;;
esac
