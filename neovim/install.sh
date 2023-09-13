nn#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    # install nvim
    info "installing neovim"
    $( #run in subshell to not permanently change to that folder
    cd "$HOME/.local/bin"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    )
    link_file :"$HOME/.local/bin/nvim" "nvim.appimage"
    # (alternative: install from apt, but often outdated)
    # sudo apt install neovim

    # get astronvim
    info "getting astronvim"
    rm -rf "$HOME/.config/nvim" # TODO: ask for confirmation
    git clone "https://github.com/AstroNvim/AstroNvim" "$HOME/.config/nvim"

    # add user config
    info "adding user config"
    link_file "./user.symlink" "$HOME/.config/nvim/lua/user"
    ;;

  "windows" )
    # install nvim
    info "installing neovim"
    scoop bucket add main
    scoop install gcc
    scoop install neovim

    # get astronvim
    info "getting astronvim"
    rm -rf "$USERPROFILE/AppData/Local/nvim" # TODO: ask for confirmation
    git clone "https://github.com/AstroNvim/AstroNvim" "$USERPROFILE/AppData/Local/nvim"
    
    # add user config
    link_file "./user.symlink" "$USERPROFILE/AppData/Local/nvim/lua/user"
    ;;

  "macos" )
    # install nvim
    info "installing neovim"
    brew install neovim

    # get astronvim
    info "getting astronvim"
    rm -rf "$HOME/.config/nvim" # TODO: ask for confirmation
    git clone "https://github.com/AstroNvim/AstroNvim" "$HOME/.config/nvim"

    # add user config
    info "adding user config"
    link_file "./user.symlink" "$HOME/.config/nvim/lua/user" 
    ;;

  * )
    ;;
esac
