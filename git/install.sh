#!/usr/bin/env bash

source ../shared.sh

info "Linking git config"
link_public_resource "./gitconfig" "$HOME/.gitconfig"
link_secret_resource "gitconfig_secrets" "$HOME/.gitconfig_secrets"

info "Installing lazygit (also needed for neovim)"
case "$OS" in
  "linux" )
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo ~/Downloads/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf ~/Downloads/llazygit.tar.gz ~/Downloads/llazygit
    sudo install ~/Downloads/llazygit /usr/local/bin
    ;;

  "windows" )
    choco install lazygit
    ;;

  "macos" )
    brew install lazygit
    ;;
    
  * )
    ;;
esac
