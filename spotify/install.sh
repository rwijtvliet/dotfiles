#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app"
    snap install spotify
    info "Adding to launcher"
    sudo cp /var/lib/snapd/desktop/applications/*.desktop /usr/share/applications/ 
    ;;

  "windows" )
    info "Installing app"
    scoop install spotify
    ;;

  "macos" )
    info "Installing app"
    brew install --cask spotify
    ;;
    
  * )
    ;;
esac
