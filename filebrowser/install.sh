#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install dolphin dolphin-plugins konsole kio kio-extras qt5ct kde-cli-tools breeze-icon-theme
    ;;
    
  "windows" )
    fail "to-do"
    exit 1
    ;;

  "macos" )
    fail "to-do"
    ;;
    
  * )
    ;;
esac
