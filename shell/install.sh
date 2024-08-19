#!/usr/bin/env bash

source ../shared.sh

link_osunspecific_files() {
  link_public_resource "./bashrc" "$HOME/.bashrc"
  link_public_resource "./zshrc" "$HOME/.zshrc"
  link_public_resource "./shell_aliases" "$HOME/.shell_aliases"
  link_secret_resource "shell_secrets" "$HOME/.shell_secrets"
}

case "$OS" in
  "linux" )
    info "Installing bash"
    sudo apt install bash

    info "Installing zsh"
    sudo apt install zsh
    # oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    info "Linking config"
    link_osunspecific_files
    link_public_resource "./shell_osspecific_linux" "$HOME/.shell_osspecific"
    sudo chsh -s $(which zsh) $(whoami)  #make default

    info "Installing shell utilities"
    # eza
    sudo apt install gpg
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
    # zoxide
    sudo apt install -y zoxide
    ;;

  "windows" )
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./shell_osspecific_windows" "$HOME/.shell_osspecific"
    ;;

  "macos" )
    info "Installing bash"
    brew install bash
    echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells  # allow usage as shell
    
    info "Installing zsh"
    brew install zsh
    echo /opt/homebrew/bin/zsh | sudo tee -a /etc/shells  # allow usage as shell
    chsh -s /opt/homebrew/bin/zsh  #make default
    
    info "Linking config"
    link_osunspecific_files
    link_public_resource "./shell_osspecific_macos" "$HOME/.shell_osspecific"

    info "Installing shell utilities"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting eza zoxide
    ;;

  * )
    ;;
esac
