#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    # install
    sudo add-apt-repository ppa:aslatter/ppa -y    
    sudo apt install alacritty
    # config
    mkdir -p "$HOME/.config/alacritty/"
    link_file "./alacritty_linux.yml.symlink" "$HOME/.config/alacritty/alacritty"
    ;;

  "windows" )
    # install
    scoop install alacritty
    # config
    mkdir -p "$APPDATA/alacritty/"
    link_file "./alacritty_windows.yml.symlink" "$APPDATA/alacritty/alacritty.yml"
    ;;

  * )
    ;;
esac
