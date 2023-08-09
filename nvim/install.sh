#!/bin/bash

source ../shared.sh

overwrite_all=false backup_all=false skip_all=false

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
