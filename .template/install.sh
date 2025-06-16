#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    # Skip if irrelevant for this OS
    skip
    ;;

  "windows" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
    ;;

  "macos" )
    info "Installing app"
    sudo apt install neovim
    info "Linking config"
    link_public_resource "./file_with_data.symlink" "$HOME/.dotfile_for_app"
    ;;
    
  * )
    ;;
esac
