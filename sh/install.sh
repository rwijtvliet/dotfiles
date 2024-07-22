#!/usr/bin/env bash

source ../shared.sh

link_osunspecific_files() {
  link_public_resource "./bashrc" "$HOME/.bashrc"
  link_public_resource "./zshrc" "$HOME/.zshrc"
  link_public_resource "./sh_aliases" "$HOME/.sh_aliases"
  link_secret_resource "sh_secrets" "$HOME/.sh_secrets"
}

case "$OS" in
  "linux" )
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./sh_osspecific_linux" "$HOME/.sh_osspecific"
    ;;

  "windows" )
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./sh_osspecific_windows" "$HOME/.sh_osspecific"
    ;;

  "macos" )
    info "Installing bash"
    brew install bash
    echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells  # allow usage as shell
    
    info "Installing zsh"
    brew install zsh
    echo /opt/homebrew/bin/zsh | sudo tee -a /etc/shells  # allow usage as shell
    chsh -s /opt/homebrew/bin/zsh  #make default
    
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./sh_osspecific_macos" "$HOME/.sh_osspecific"

    info "Installing sh utilities"
    brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting eza zoxide
    ;;

  * )
    ;;
esac
