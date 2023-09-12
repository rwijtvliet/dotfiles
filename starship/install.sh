#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app"
    sudo apt install cargo cmake
    cargo install starship --locked
    info "Linking config"
    link_file "./starship.toml.symlink" "$HOME/.config/starship.toml"
    ;;

  "windows" )
    info "Installing app"
    scoop install starship
    info "Linking config"
    link_file "./starship.toml.symlink" "$HOME/.config/starship.toml"
    ;;

  "macos" )
    info "Installing app"
    brew install starship
    info "Linking config"
    link_file "./starship.toml.symlink" "$HOME/.config/starship.toml"
    ;;

  * )
    ;;
esac

todo "Restart bash to use starship."
