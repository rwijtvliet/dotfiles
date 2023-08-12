#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install cargo cmake
    cargo install starship --locked
    link_file "./starship.toml.symlink" "$HOME/.config/starship.toml"
    ;;

  "windows" )
    scoop install starship
    link_file "./starship.toml.symlink" "$HOME/.config/starship.toml"
    ;;

  * )
    ;;
esac

todo "Restart bash to use starship."
