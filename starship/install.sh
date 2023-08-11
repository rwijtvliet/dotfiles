#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo apt install cargo cmake
    cargo install starship --locked
    starship preset nerd-font-symbols -o ~/.config/starship.toml  
    ;;

  "windows" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
    ;;

  * )
    ;;
esac
