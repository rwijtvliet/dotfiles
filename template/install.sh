#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install neovim
    ;;

  "windows" )
    fail "to-do"
    ;;

  * )
    ;;
esac
