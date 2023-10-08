#!/usr/bin/env bash

source ../shared.sh

ROOT="syncNone/Software/qmk_firmware"
ERGODOX="keyboards/ergodox_ez/keymaps/rwijtvliet"
ATREUS="keyboards/keyboardio/atreus/keymaps/rwijtvliet"

setup_and_config() {
  home=$1
  
  info "Running setup"
  qmk setup --home "$home"/$ROOT
  
  info "Linking config for atreus"
  rm -rf   "$home"/"$ROOT"/"$ATREUS"
  mkdir -p "$home"/"$ROOT"/"$ATREUS"
  link_public_resource "./qmk/common/keymap_partial.c"   "$home"/"$ROOT"/"$ATREUS"/keymap_partial.c
  link_public_resource "./qmk/common/dicts.def"          "$home"/"$ROOT"/"$ATREUS"/dicts.def
  link_public_resource "./qmk/common/config.h"           "$home"/"$ROOT"/"$ATREUS"/config.h
  link_public_resource "./qmk/atreus/atreus.c"           "$home"/"$ROOT"/"$ATREUS"/atreus.c
  link_public_resource "./qmk/atreus/keymap.c"           "$home"/"$ROOT"/"$ATREUS"/keymap.c
  link_public_resource "./qmk/atreus/rules.mk"           "$home"/"$ROOT"/"$ATREUS"/rules.mk
  link_secret_resource "qmk/common/combos.def"           "$home"/"$ROOT"/"$ATREUS"/combos.def
    
  info "Linking config for ergodox_ez"
  rm -rf   "$home"/"$ROOT"/"$ERGODOX"
  mkdir -p "$home"/"$ROOT"/"$ERGODOX"
  link_public_resource "./qmk/common/keymap_partial.c"   "$home"/"$ROOT"/"$ERGODOX"/keymap_partial.c
  link_public_resource "./qmk/common/dicts.def"          "$home"/"$ROOT"/"$ERGODOX"/dicts.def
  link_public_resource "./qmk/common/config.h"           "$home"/"$ROOT"/"$ERGODOX"/config.h
  link_public_resource "./qmk/ergodox_ez/ergodox.c"      "$home"/"$ROOT"/"$ERGODOX"/ergodox.c
  link_public_resource "./qmk/ergodox_ez/keymap.c"       "$home"/"$ROOT"/"$ERGODOX"/keymap.c
  link_public_resource "./qmk/ergodox_ez/rules.mk"       "$home"/"$ROOT"/"$ERGODOX"/rules.mk
  link_secret_resource "qmk/common/combos.def"           "$home"/"$ROOT"/"$ERGODOX"/combos.def
  
  info "run 'qmk list-keyboards' to see all supported keyboards. Here are the first 20:"
  qmk list-keyboards 2>&1 | head -n 20
  info "Let's try building the default layout for a keyboard"
  try "qmk compile -kb ergodox_ez -km default"
  info "Setting standard keyboard as ergodox_ez"
  qmk config user.keyboard=ergodox_ez
  qmk config user.keymap=rwijtvliet
  todo "To compile the ergodox, use 'qmk compile -kb ergodox_ez -km rwijtvliet"
  todo "To compile the atreus, replace 'ergodox_ez' with 'keyboardio/atreus'"
  todo "To flash the compiled file to the keyboard, replace 'compile' with 'flash'"
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
    info "Installing app (if not up-to-date, this will take several hours (!) on apple silicon)"
    brew install qmk/qmk/qmk
    setup_and_config $HOME
    ;;
    
  * )
    ;;
esac
