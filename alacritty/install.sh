#!/usr/bin/env bash

source ../shared.sh

install_themes () {
  # update nodejs
  sudo npm cache clean -f
  sudo npm install -g n
  sudo n stable
  # install
  if sudo npm i -g alacritty-themes; then
    success "installed the program"
    alacritty-themes Gruvbox-Dark
    success "set Gruvbox-Dark theme"
    todo "Change the alacritty theme interactively with 'alacritty-themes'. Alternatively, use 'alacritty-themes <theme>', and see here for the available themes: https://github.com/rajasegar/alacritty-themes/tree/master/themes"
  else
    fail "Could not install theme selector"
  fi
}

case "$OS" in
  "linux" )
    # install
    info "Installing app"
    sudo add-apt-repository ppa:aslatter/ppa -y    
    sudo apt install alacritty
    # config
    info "Linking config file"
    mkdir -p "$HOME/.config/alacritty/"
    link_public_resource "./alacritty_osspecific_linux.toml" "$HOME/.config/alacritty/alacritty.toml"
    link_public_resource "./alacritty_common.toml" "$HOME/.config/alacritty/alacritty_common.toml"
    # themes
    info "Installing theme selector"
    install_themes
    ;;

  "windows" )
    # install
    info "Installing app"
    scoop bucket add extras
    scoop install extras/alacritty
    # config
    info "Linking config file"
    mkdir -p "$APPDATA/alacritty/"
    link_public_resource "./alacritty_osspecific_windows.yml" "$APPDATA/alacritty/alacritty.yml"
    link_public_resource "./alacritty_common.toml" "$APPDATA/alacritty/alacritty_common.toml"
    # themes
    info "Installing theme selector"
    install_themes
    ;;
  
  "macos" )
    # install
    info "Installing app"
    brew install --cask alacritty
    # config
    info "Linking config file"
    mkdir -p "$HOME/.config/alacritty/"
    link_public_resource "./alacritty_osspecific_macos.toml" "$HOME/.config/alacritty/alacritty.toml"
    link_public_resource "./alacritty_common.toml" "$HOME/.config/alacritty/alacritty_common.toml"
    # themes
    info "Installing theme selector"
    install_themes
    ;;

  * )
    ;;
esac
