#!/bin/bash

# create symlink to espanso 

source ../shared.sh


case "$OS" in
  "linux" )
    if [ -z $XDG_CONFIG_HOME ] || [ ! -d $XDG_CONFIG_HOME ]
    then
      fail "linux distribution does not have its XDG_CONFIG_HOME variable set: $XDG_CONFIG_HOME"
      exit 1
    fi
      
    # install
    cd ~/downloads/
    wget https://github.com/federico-terzi/espanso/releases/download/v2.1.8/espanso-debian-x11-amd64.deb
    sudo apt install ./espanso-debian-x11-amd64.deb

    # register service
    espanso service register

    # create symlink to configuration
    link_file ./espanso.private $XDG_CONFIG_HOME/espanso
     
    # start
    espanso start
    ;;

  "windows" )
    # install
    scoop install espanso

    # create symlink to configuration
    link_file ./espanso.private $APPDATA/espanso
    ;;

  * )
    ;;
esac
