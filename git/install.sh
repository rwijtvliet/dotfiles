#!/usr/bin/env bash

source ../shared.sh


case "$OS" in
  "linux" )
    info "Linking git config"
    link_public_resource "./gitconfig" "$HOME/.gitconfig"
    link_secret_resource "gitconfig_secrets" "$HOME/.gitconfig_secrets"
    link_public_resource "gitconfig_osspecific_linux" "$HOME/.gitconfig_osspecific"

    info "Installing lazygit (also needed for neovim)"
    ( # subshell because we change folder
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        info "Latest version: $LAZYGIT_VERSION"
        cd ~/Downloads/ || exit
        curl -Lo ./lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf ./lazygit.tar.gz 
        sudo install ./lazygit /usr/local/bin
    )
    info "Linking lazygit config"
    link_public_resource "./config.yml" "$HOME/.config/lazygit/config.yml"
    ;;

  "windows" )
    info "Linking git config"
    link_public_resource "./gitconfig" "$HOME/.gitconfig"
    link_secret_resource "gitconfig_secrets" "$HOME/.gitconfig_secrets"
    link_public_resource "gitconfig_osspecific_windows" "$HOME/.gitconfig_osspecific"

    info "Installing lazygit (also needed for neovim)"
    choco install lazygit
    info "Linking lazygit config"
    link_public_resource "./config.yml" "$APPDATA\lazygit\config.yml"
    ;;

  "macos" )
    info "Linking git config"
    link_public_resource "./gitconfig" "$HOME/.gitconfig"
    link_secret_resource "gitconfig_secrets" "$HOME/.gitconfig_secrets"
    link_public_resource "gitconfig_osspecific_macos" "$HOME/.gitconfig_osspecific"

    info "Installing lazygit (also needed for neovim)"
    brew install lazygit
    info "Linking lazygit config"
    link_public_resource "./config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
    ;;
    
  * )
    ;;
esac
