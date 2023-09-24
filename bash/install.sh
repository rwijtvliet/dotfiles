#!/usr/bin/env bash

source ../shared.sh

link_osunspecific_files() {
  link_public_resource "./bashrc.symlink" "$HOME/.bashrc"
  link_public_resource "./bash_aliases.symlink" "$HOME/.bash_aliases"
  link_secret_resource "bash_secrets.symlink" "$HOME/.bash_secrets"
}

case "$OS" in
  "linux" )
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./bash_osspecific_linux.symlink" "$HOME/.bash_osspecific"
    ;;

  "windows" )
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./bash_osspecific_windows.symlink" "$HOME/.bash_osspecific"
    ;;

  "macos" )
    info "Installing app"
    brew install bash
    PATH="/opt/homebrew/bin:$PATH" #line also included in bashrc
    echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells  # allow usage as shell
    chsh -s /opt/homebrew/bin/bash  #make default
    
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./bash_osspecific_macos.symlink" "$HOME/.bash_osspecific"
    ;;

  * )
    ;;
esac
