#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    skip
    ;;

  "windows" )
    skip
    ;;

  "macos" )
    info "Linking config"
    link_public_resource "./undead.bundle" "$HOME/Library/Keyboard Layouts/undead.bundle"
    ;;
    
  * )
    ;;
esac
