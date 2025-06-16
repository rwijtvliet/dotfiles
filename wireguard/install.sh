#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    # raise error to alert user that this script is missing
    info "Installing app"
    sudo apt install wireguard
    $(
    cd ~/Downloads/
    rm ./wireguard_amd64.deb
    wget https://cdn.cyberinnovations.de/downloads/wireguard_amd64.deb
    sudo apt install ./wireguard_amd64.deb
    )
    
    info "Linking configuration"
    mkdir -p "$HOME/.config/wireguard"
    sudo mkdir -p "/etc/wireguard"
    link_secret_resource "wireguard/ruudxps20.conf" "$HOME/.config/wireguard/ruudxps20.conf"
    link_secret_resource "wireguard/ruudxps20.conf" "/etc/wireguard/ruudxps20.conf"
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
    mkdir -p "$HOME/.config/wireguard"
    sudo mkdir -p "/etc/wireguard"
    link_secret_resource "wireguard/ruudmac23.conf" "$HOME/.config/wireguard/ruudmac23.conf"
    link_secret_resource "wireguard/ruudmac23.conf" "/etc/wireguard/ruudmac23.conf"
    ;;
    
  * )
    ;;
esac
