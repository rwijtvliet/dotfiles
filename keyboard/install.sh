#!/usr/bin/env bash

source ../shared.sh

ROOT="Software/qmk_firmware"
ERGODOX="keyboards/ergodox_ez/keymaps/rwijtvliet"
ATREUS="keyboards/keyboardio/atreus/keymaps/rwijtvliet"

setup_and_config() {
  home=$1
  
  info "Running setup"
  qmk setup --home "$home"/$ROOT
  
  info "Linking config"
  rm -rf "$home"/"$ROOT"/"$ERGODOX"
  rm -rf "$home"/"$ROOT"/"$ATREUS"
  link_public_resource "./qmk"/"$ERGODOX" "$home"/"$ROOT"/"$ERGODOX"
  link_public_resource "./qmk"/"$ATREUS" "$home"/"$ROOT"/"$ATREUS"
    
  info "run 'qmk list-keyboards' to see all supported keyboards. Here are the first 20:"
  qmk list-keyboards 2>&1 | head -n 20
  info "Let's try building the default layout for a keyboard"
  try "qmk compile -kb ergodox_ez -km default"
  info "Setting standard keyboard as ergodox_ez"
  qmk config user.keyboard=ergodox_ez
  qmk config user.keymap=rwijtvliet
}


case "$OS" in
  "linux" )
    info "Installing app"
    python3 -m pip install --user qmk
    setup_and_config $HOME
    ;;

  "windows" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
    ;;

  "macos" )
    info "Installing app (will take several hours (!) on apple silicon)"
    brew install qmk/qmk/qmk
    setup_and_config $HOME
    ;;
    
  * )
    ;;
esac
