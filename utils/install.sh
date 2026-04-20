#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
"linux")
  sudo apt update
  sudo apt install npm snapd ripgrep cifs-utils
  sudo apt upgrade

  # rust
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  # fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  #copyq (clipboard)
  sudo add-apt-repository ppa:hluk/copyq
  sudo apt update
  sudo apt install copyq
  ;;

"windows")
  scoop install wget nodejs fzf curl tar rustup

  scoop update *
  ;;

"macos")
  info "Installing gnu versions"
  brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
  PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" # also in .bashrc
  info "Installing java"
  brew install java
  brew install openjdk
  todo "installed java - but probably won't work anyway. "
  brew install npm wget nodejs rg fd fzf
  ;;

*) ;;
esac
