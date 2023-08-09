#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install neovim
    link_file "./file_with_data.symlink" "$HOME/.dotfile_for_app"
    ;;

  "windows" )
    fail "to-do"
    ;;

  * )
    ;;
esac
