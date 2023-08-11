#!/bin/bash

source ../shared.sh

install_themes () {
  npm i -g alacritty-themes
  success "installed the program"
  alacritty-themes Gruvbox-Dark
  success "set Gruvbox-Dark theme"
  todo "Change the alacritty theme interactively with 'alacritty-themes'. Alternatively, use 'alacritty-themes <theme>', and see here for the available themes: https://github.com/rajasegar/alacritty-themes/tree/master/themes"
}

case "$OS" in
  "linux" )
    # install
    sudo add-apt-repository ppa:aslatter/ppa -y    
    sudo apt install alacritty
    # config
    mkdir -p "$HOME/.config/alacritty/"
    link_file "./alacritty_linux.yml.symlink" "$HOME/.config/alacritty/alacritty.yml"
    # themes
    install_themes
    ;;

  "windows" )
    # install
    scoop install alacritty
    # config
    mkdir -p "$APPDATA/alacritty/"
    link_file "./alacritty_windows.yml.symlink" "$APPDATA/alacritty/alacritty.yml"
    # # themes
    install_themes
    ;;

  * )
    ;;
esac
