#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    skip
    ;;

  "windows" )
    skip
    ;;

  "macos" )
    brew install koekeishiya/formulae/yabai
    brew install skhd
    brew upgrade yabai
    link_file "./yabairc.symlink" "$HOME/.config/yabai/yabairc"
    link_file "./skhdrc.symlink" "$HOME/.config/skhd/skhdrc"
    skhd --start-service
    yabai --start-service
    
  * )
    ;;
esac
