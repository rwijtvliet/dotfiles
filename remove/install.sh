#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Removing libreoffice"
    sudo apt-get remove --purge libreoffice*
    info "Removing home folders"
    rmdir ~/Pictures
    rmdir ~/Documents
    rmdir ~/Music
    rmdir ~/Public
    rmdir ~/Templates
    rmdir ~/Examples
    rmdir ~/Videos
    ;;

  "windows" )
    ;;

  "macos" )
    ;;
    
  * )
    ;;
esac
