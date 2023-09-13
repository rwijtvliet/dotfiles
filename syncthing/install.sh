#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
    sudo apt-get update
    sudo apt-get install syncthing
    ;;

  "windows" )
    scoop install syncthing
    choco install synctrayzor
    ;;

  "macos" )
    brew install syncthing
    brew services start syncthing
    ;;

  * )
    ;;
esac

todo "Verify/Ensure that syncthing is running on startup."
todo "Set-up folders to synchronize."



