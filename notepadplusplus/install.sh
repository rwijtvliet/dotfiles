#!/bin/bash

source ../shared.sh

info "Installing notepad plus-plus"
case "$OS" in
  "linux" )
    skip
    ;;

  "windows" )
    try "scoop install notepadplusplus"
    ;;

  "macos" )
    skip
    ;;
    
  * )
    ;;
esac
