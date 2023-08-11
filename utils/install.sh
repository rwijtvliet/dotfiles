#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install npm

    sudo apt update
    sudo apt upgrade
    ;;

  "windows" )
    scoop install wget   
    scoop install npm
    scoop install nodejs

    scoop update *
    ;;

  * )
    ;;
esac
