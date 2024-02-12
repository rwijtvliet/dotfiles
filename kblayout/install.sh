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
    info "Linking config"
    copy_public_resource "./undead.bundle/Contents/Resources/Dvorak undead.keylayout" "$HOME/Library/Keyboard Layouts/Dvorak undead.keylayout"
    copy_public_resource "./undead.bundle/Contents/Resources/U.S. undead.keylayout" "$HOME/Library/Keyboard Layouts/U.S. undead.keylayout"
    ;;
    
  * )
    ;;
esac
