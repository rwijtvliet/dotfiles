#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    todo "Rofi?"
    ;;

  "windows" )
    skip
    ;;

  "macos" )
    info "Installing app"
    brew install raycast
    todo "Restore backup from raycast menu. Backup of settings found here: $(realpath './Raycast 2021-12-28 00.26.07.rayconfig')"
    ;;
    
  * )
    ;;
esac
