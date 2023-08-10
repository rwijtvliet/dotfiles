#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    # install nvim
    sudo apt install neovim

    # get astronvim
    rm -rf "$HOME/.config/nvim" # TODO: ask for confirmation
    git clone "https://github.com/AstroNvim/AstroNvim" "$HOME/.config/nvim"

    # add user config
    link_file "./user.symlink" "$HOME/.config/nvim/lua/user"
    ;;

  "windows" )
    # install nvim
    scoop bucket add main
    scoop install neovim

    # get astronvim
    rm -rf "$USERPROFILE/AppData/Local/nvim" # TODO: ask for confirmation
    git clone "https://github.com/AstroNvim/AstroNvim" "$USERPROFILE/AppData/Local/nvim"
    
    # add user config
    link_file "./user.symlink" "$USERPROFILE/AppData/Local/nvim/lua/user"
    ;;

  * )
    ;;
esac
