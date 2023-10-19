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
    $( # install client to communicate with spotify app 
      cd ~/Downloads/
      git clone https://github.com/mihirlad55/polybar-spotify-module
      cd polybar-spotify-module/src/
      sudo make install 
      # run at system start
      systemctl --user enable spotify-listener
    )
    sudo apt install i3 playerctl brightnessctl
    sudo snap install pulseaudio
    sudo apt install polybar rofi
    sudo usermod -aG video $USER
    todo "To enable natural scrolling and the possibility to 'tap' (instead of press), add the following lines to the correct section in /usr/share/X11/xorg.conf.d/40-libinput.conf (you need admin priviliges):"
    todo "    'Option "NaturalScrolling" "True"'"
    todo "    'Option "ClickMethod" "clickfinder"'"
    todo "    'Option "Tapping" "on"'"
    info "Linking config for i3"
    mkdir -p "$HOME/.config/i3"
    link_public_resource "./linux/i3/config" "$HOME/.config/i3/config" 
    link_public_resource "./linux/i3/i3status.conf" "$HOME/.config/i3/i3status.conf"
    info "Linking config for polybar"
    mkdir -p "$HOME/.config/polybar"
    link_public_resource "./linux/polybar/launch.sh" "$HOME/.config/polybar/launch.sh"
    link_public_resource "./linux/polybar/config.ini" "$HOME/.config/polybar/config.ini"
    info "Linking config for rofi"
    mkdir -p "$HOME/.config/rofi"
    link_public_resource "./linux/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"
    ;;

  "windows" )
    skip
    ;;

  "macos" )
    info "Removing app if already installed"
    brew remove yabai skhd
    rm -rf "$HOME/.config/yabai"
    rm -rf "$HOME/.config/skhd"
    sudo rm /private/etc/sudoers.d/yabai
    brew update
    
    info "Installing app(s)"
    brew install koekeishiya/formulae/yabai
    brew install skhd
    brew install jq 
    brew upgrade yabai
    
    info "Linking config"
    mkdir -p "$HOME/.config/yabai"
    mkdir -p "$HOME/.config/skhd"
    link_public_resource "./macos/yabairc" "$HOME/.config/yabai/yabairc"
    link_public_resource "./macos/skhdrc" "$HOME/.config/skhd/skhdrc"

    info "Setting sudo priviliges to yabai scripting addition"
    echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai)) --load-sa" > /tmp/yabai
    sudo cp /tmp/yabai /private/etc/sudoers.d/yabai
    
    info "starting yabai and skhd"
    skhd --start-service
    yabai --start-service
    success "Done, but Yabai might only work partially. To enable completely, the System Integrity Protection must be disabled."
    todo "Check output below to confirm if SIP is disabled. If not, google 'yabai disable SIP'."
    csrutil status
    ;;
    
  * )
    ;;
esac
