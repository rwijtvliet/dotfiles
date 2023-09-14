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
    info "Installing app: unnatural scrolling (to have normal scrolling on mouse)"
    brew install --cask unnaturalscrollwheels
    info "Installing app: top notch (to make menu bar black)"
    brew install --cask topnotch
    ;;
    
  * )
    ;;
esac
