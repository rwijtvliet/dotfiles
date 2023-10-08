#!/usr/bin/env bash

source ../shared.sh

ROOT="syncNone/Software/qmk_firmware"
ERGODOX="keyboards/ergodox_ez/keymaps/rwijtvliet"
ATREUS="keyboards/keyboardio/atreus/keymaps/rwijtvliet"
LAST_SUCCESSFUL_QMK_TAG="0.22.10"  # see https://github.com/qmk/qmk_firmware/tags


setup_and_config() {
  home=$1
  
  info "Running setup with LATEST qmk version. See below if this is not working with existing files."
  qmk setup --home "$home"/$ROOT
  
  info "Linking config for atreus"
  rm -rf   "$home"/"$ROOT"/"$ATREUS"
  mkdir -p "$home"/"$ROOT"/"$ATREUS"
  link_public_resource "./qmk/common/keymap_partial.c"     "$home"/"$ROOT"/"$ATREUS"/keymap_partial.c
  link_public_resource "./qmk/common/dicts.def"            "$home"/"$ROOT"/"$ATREUS"/dicts.def
  link_public_resource "./qmk/common/config.h"             "$home"/"$ROOT"/"$ATREUS"/config.h
  link_public_resource "./qmk/keyboardio_atreus/atreus.c"  "$home"/"$ROOT"/"$ATREUS"/atreus.c
  link_public_resource "./qmk/keyboardio_atreus/keymap.c"  "$home"/"$ROOT"/"$ATREUS"/keymap.c
  link_public_resource "./qmk/keyboardio_atreus/rules.mk"  "$home"/"$ROOT"/"$ATREUS"/rules.mk
  link_secret_resource "qmk/common/combos.def"             "$home"/"$ROOT"/"$ATREUS"/combos.def
    
  info "Linking config for ergodox_ez"
  rm -rf   "$home"/"$ROOT"/"$ERGODOX"
  mkdir -p "$home"/"$ROOT"/"$ERGODOX"
  link_public_resource "./qmk/common/keymap_partial.c"     "$home"/"$ROOT"/"$ERGODOX"/keymap_partial.c
  link_public_resource "./qmk/common/dicts.def"            "$home"/"$ROOT"/"$ERGODOX"/dicts.def
  link_public_resource "./qmk/common/config.h"             "$home"/"$ROOT"/"$ERGODOX"/config.h
  link_public_resource "./qmk/ergodox_ez_glow/ergodox.c"   "$home"/"$ROOT"/"$ERGODOX"/ergodox.c
  link_public_resource "./qmk/ergodox_ez_glow/keymap.c"    "$home"/"$ROOT"/"$ERGODOX"/keymap.c
  link_public_resource "./qmk/ergodox_ez_glow/rules.mk"    "$home"/"$ROOT"/"$ERGODOX"/rules.mk
  link_secret_resource "qmk/common/combos.def"             "$home"/"$ROOT"/"$ERGODOX"/combos.def
  
  info "run 'qmk list-keyboards' to see all supported keyboards. Here are the first 20:"
  qmk list-keyboards 2>&1 | head -n 20
  qmk config user.keymap=rwijtvliet
  todo "To compile the ergodox, use 'qmk compile -kb ergodox_ez/glow -km rwijtvliet"
  todo "To compile the atreus, replace 'ergodox_ez/glow' with 'keyboardio/atreus'"
  todo "To flash the compiled file to the keyboard, replace 'compile' with 'flash'"
  info "Let's try compiling our ergodox keymap:"
  try "qmk compile -kb ergodox_ez/glow -km rwijtvliet"
  info "Let's try compiling our atreus keymap:"
  try "qmk compile -kb keyboardio/atreus -km rwijtvliet"

  todo "If this was not successful, try setting up qmk using the branch that was used and working last time. Use the following command: 'qmk setup --home "$home"/$ROOT --branch $LAST_SUCCESSFUL_QMK_TAG' "
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
