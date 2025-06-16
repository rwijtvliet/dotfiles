#!/usr/bin/env bash

# Things that cannot be installed but must be handled by user, later

source ../shared.sh

case "$OS" in
  "linux" )
    info "Adding another password to encrypted drive (ctrl-c to skip)"
    mountpoint="/dev/$(lsblk -f | grep crypto | cut -d ' ' -f1 | sed  's/[^a-zA-Z0-9]//g')"
    sudo cryptsetup luksAddKey $mountpoint
    todo "If this did not work, or if you want to add more passwords, use:"
    todo ">>> sudo cryptsetup luksAddKey $mountpoint"
    ;;

  "windows" )
    skip
    ;;

  "macos" )
    skip
    ;;
    
  * )
    ;;
esac
