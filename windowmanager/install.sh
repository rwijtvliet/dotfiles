#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app"
    $( # to get latest stable version of i3
      cd ~/Downloads/
      /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
      sudo apt install ./keyring.deb
      echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
      sudo apt update
    )
    sudo apt install i3 playerctl brightnessctl
    sudo snap install pulseaudio
    sudo apt install polybar 
    sudo usermod -aG video $USER
    todo "To enable natural scrolling and the possibility to 'tap' (instead of press), add the following lines to the correct section in /usr/share/X11/xorg.conf.d/40-libinput.conf (you need admin priviliges):"
    todo "    'Option "NaturalScrolling" "True"'"
    todo "    'Option "ClickMethod" "clickfinder"'"
    todo "    'Option "Tapping" "on"'"
    info "Linking config"
    mkdir -p "$HOME/.config/i3"
    link_public_resource "./i3/config" "$HOME/.config/i3/config" 
    link_public_resource "./i3/i3status.conf" "$HOME/.config/i3/i3status.conf"
    mkdir -p "$HOME/.config/polybar"
    link_public_resource "./i3/polybar/launch.sh" "$HOME/.config/polybar/launch.sh"
    link_public_resource "./i3/polybar/config.ini" "$HOME/.config/polybar/config.ini"
    ;;

  "windows" )
    skip
    ;;

  "macos" )
    info "Installing app(s)"
    brew install koekeishiya/formulae/yabai
    brew install skhd
    brew install jq 
    brew upgrade yabai
    info "Linking config"
    mkdir -p "$HOME/.config/yabai"
    mkdir -p "$HOME/.config/skhd"
    link_public_resource "./yabai/yabairc" "$HOME/.config/yabai/yabairc"
    link_public_resource "./yabai/skhdrc" "$HOME/.config/skhd/skhdrc"
    skhd --start-service
    yabai --start-service
    success "Yabai might only work partially. To enable completely, disable the System Integrity Protection; google 'yabai disable SIP'."
    todo "Check output below to see where SIP is disabled:"
    csrutil status
    ;;
    
  * )
    ;;
esac
