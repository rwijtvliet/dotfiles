#!/bin/bash

source ../shared.sh

install_extensions () {
  for ext in $(cat ./extensions); do
    code --install-extension $ext
  done
}

case "$OS" in
  "linux" )
    sudo apt install gnupg2 software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install code
    install_extensions
    ;;

  "windows" )
    scoop install vscode
    install_extensions
    ;;

  * )
    ;;
esac

todo "The keybindings and settings are stored in this folder (vscode/), but not linked or copied to the folder where vscode is installed. The reason is that vscode provides its own sync; the files here are only for backup."
