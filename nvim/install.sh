#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install neovim
    link_file ./user.symlink $HOME/.config/nvim/lua/user 
    ;;

  "windows" )
    fail "to-do"
    ;;

  * )
    ;;
esac
