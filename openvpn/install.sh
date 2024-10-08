#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    # raise error to alert user that this script is missing
    info "Installing app"
    sudo apt install openvpn
    
    info "Linking configuration"
    mkdir -p "$HOME/.config/openvpn"
    sudo mkdir -p "/etc/openvpn"
    link_secret_resource "openvpn/loonopzand.ovpn" "$HOME/.config/openvpn/loonopzand.ovpn"
    link_secret_resource "openvpn/loonopzand.ovpn" "/etc/openvpn/loonopzand.ovpn"
    ;;

  "windows" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
    ;;

  "macos" )
    info "Installing app"
    todo "figure out how to install openvpn on mac"
    
    info "Linking configuration"
    mkdir -p "$HOME/.config/openvpn"
    sudo mkdir -p "/etc/openvpn"
    link_secret_resource "openvpn/loonopzand.ovpn" "$HOME/.config/openvpn/loonopzand.ovpn"
    link_secret_resource "openvpn/loonopzand.ovpn" "/etc/openvpn/loonopzand.ovpn"
    ;;
    
  * )
    ;;
esac
