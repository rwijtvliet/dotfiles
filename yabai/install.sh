#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    skip
    ;;

  "windows" )
    skip
    ;;

  "macos" )
    info "Installing app"
    brew install koekeishiya/formulae/yabai
    brew install skhd
    brew install jq 
    brew upgrade yabai
    info "Linking config"
    mkdir -p "$HOME/.config/yabai"
    mkdir -p "$HOME/.config/skhd"
    link_public_resource "./yabairc.symlink" "$HOME/.config/yabai/yabairc"
    link_public_resource "./skhdrc.symlink" "$HOME/.config/skhd/skhdrc"
    skhd --start-service
    yabai --start-service
    success "Yabai should already work, but only partially."
    todo "To enable completely, disable the System Integrity Protection; google 'yabai disable SIP'."
    ;;
    
  * )
    ;;
esac
