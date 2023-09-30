#!/usr/bin/env bash

source ../shared.sh

link_osunspecific_files() {
  link_public_resource "./bashrc" "$HOME/.bashrc"
  link_public_resource "./bash_aliases" "$HOME/.bash_aliases"
  link_secret_resource "bash_secrets" "$HOME/.bash_secrets"
}

case "$OS" in
  "linux" )
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./bash_osspecific_linux" "$HOME/.bash_osspecific"
    ;;

  "windows" )
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./bash_osspecific_windows" "$HOME/.bash_osspecific"
    ;;

  "macos" )
    info "Installing app"
    brew install bash
    PATH="/opt/homebrew/bin:$PATH" #line also included in bashrc
    echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells  # allow usage as shell
    chsh -s /opt/homebrew/bin/bash  #make default
    
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./bash_osspecific_macos" "$HOME/.bash_osspecific"
    ;;

  * )
    ;;
esac
