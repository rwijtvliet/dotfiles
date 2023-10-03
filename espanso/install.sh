#!/usr/bin/env bash

# create symlink to espanso 

source ../shared.sh


case "$OS" in
  "linux" )
    # if [ -z $XDG_CONFIG_HOME ] || [ ! -d $XDG_CONFIG_HOME ]
    # then
    #   fail "linux distribution does not have its XDG_CONFIG_HOME variable set: $XDG_CONFIG_HOME"
    #   exit 1
    # fi
      
    # install
    info "Installing app"
    ( # subshell because we change folder
    cd ~/Downloads/
    wget https://github.com/federico-terzi/espanso/releases/download/v2.1.8/espanso-debian-x11-amd64.deb
    sudo apt install ./Downloads/espanso.deb
    )

    # register service
    espanso service register

    # create symlink to configuration
    info "Linking config"
    link_secret_resource "espanso" "$HOME/.config/espanso"
     
    # start
    espanso start
    ;;

  "windows" )
    # install
    info "Installing app"
    scoop install espanso

    # create symlink to configuration
    info "Linking config"
    link_secret_resource "espanso" "$APPDATA/espanso"
    ;;

  "macos" )
    # install
    info "Installing app"
    brew tap espanso/espanso
    brew install espanso

    # create symlink to configuration
    info "Linking config"
    link_secret_resource "espanso" "$HOME/.config/espanso"
    ;;
    
  * )
    ;;
esac
