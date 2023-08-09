#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Not needed for linux"
    ;;

  "windows" )
    # install
    powershell "iwr -useb get.scoop.sh | iex"
    powershell "Set-ExecutionPolicy RemoteSigned -scope CurrentUser" 

    # update
    scoop update
    ;;

  * )
    ;;
esac
