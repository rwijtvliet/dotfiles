#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install neovim
    link_file "./file_with_data.symlink" "$HOME/.dotfile_for_app"
    ;;

  "windows" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
    # or, if app not relevant on this system:
    skip
    ;;

  * )
    ;;
esac
