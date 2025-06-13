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
    rm espanso-debian-x11-amd64.deb
    wget https://github.com/federico-terzi/espanso/releases/download/v2.1.8/espanso-debian-x11-amd64.deb
    chmod +x ~/Downloads/espanso-debian-x11-amd64.deb
    sudo apt install ~/Downloads/espanso-debian-x11-amd64.deb
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
    link_secret_resource "espanso" "$HOME/scoop/persist/espanso/.espanso"
    todo "Start espanso with `espansod start`. If it is not working, check if it's using the correct path with `espansod path`. If it is, then it might be an issue with windows symlinks not working. Last time I installed it, I had to make a copy, which sucks for keeping things in sync, but hey, it's windows, what can you do?"
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
