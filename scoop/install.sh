#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    skip
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
