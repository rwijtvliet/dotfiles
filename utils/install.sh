#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    skip
    ;;

  "windows" )
    scoop install wget   
    ;;

  * )
    ;;
esac
