#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
    ;;

  "windows" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
    ;;

  "macos" )
    info "Installing app"
    brew install wireguard-tools
    info "Linking configuration"
    link_secret_resource "wireguard/ruudmacos.conf.symlink" "$HOME/.config/wireguard/wg0.conf"
    link_secret_resource "wireguard/ruudmacos.conf.symlink" "/etc/wireguard/wg0.conf"
    ;;
    
  * )
    ;;
esac
