#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    # install nvim
    info "Installing app"
    $( #run in subshell to not permanently change to that folder
    mkdir -p "$HOME/.local/bin"
    curl -Lo "$HOME/.local/bin/nvim" https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x "$HOME/.local/bin/nvim"
    )
    #link_public_resource "$HOME/.local/bin/nvim" "nvim.appimage"
    # (alternative: install from apt, but often outdated)
    # sudo apt install neovim

    # get astronvim
    info "getting astronvim"
    rm -rf "$HOME/.config/nvim" # TODO: ask for confirmation
    git clone "https://github.com/AstroNvim/AstroNvim" "$HOME/.config/nvim"

    # add user config
    info "adding user config"
    link_public_resource "./user" "$HOME/.config/nvim/lua/user"
    ;;

  "windows" )
    # install nvim
    info "Installing app"
    scoop bucket add main
    scoop install gcc
    scoop install neovim

    # get astronvim
    info "getting astronvim"
    rm -rf "$USERPROFILE/AppData/Local/nvim" # TODO: ask for confirmation
    git clone "https://github.com/AstroNvim/AstroNvim" "$USERPROFILE/AppData/Local/nvim"
    
    # add user config
    link_public_resource "./user" "$USERPROFILE/AppData/Local/nvim/lua/user"
    ;;

  "macos" )
    # install nvim
    info "Installing app"
    brew install neovim

    # get astronvim
    info "getting astronvim"
    rm -rf "$HOME/.config/nvim" # TODO: ask for confirmation
    git clone "https://github.com/AstroNvim/AstroNvim" "$HOME/.config/nvim"

    # add user config
    info "adding user config"
    link_public_resource "./user" "$HOME/.config/nvim/lua/user" 
    ;;

  * )
    ;;
esac
