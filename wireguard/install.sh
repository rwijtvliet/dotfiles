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
    link_secret_resource "wireguard/ruudmac23.conf" "$HOME/.config/wireguard/ruudmac23.conf"
    link_secret_resource "wireguard/ruudmac23.conf" "/etc/wireguard/ruudmac23.conf"
    ;;
    
  * )
    ;;
esac
