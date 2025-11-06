#!/usr/bin/env bash

source ../shared.sh

ROOT1="syncNone/Software/qmk_firmware"
ROOT2="syncNone/Software/qmk_firmware_zsa"

ERGODOX="$ROOT1/keyboards/ergodox_ez/keymaps/rwijtvliet"
ATREUS="$ROOT1/keyboards/keyboardio/atreus/keymaps/rwijtvliet"
VOYAGER="$ROOT2/keyboards/voyager/keymaps/rwijtvliet"

LAST_SUCCESSFUL_QMK_TAG="0.22.10"  # see https://github.com/qmk/qmk_firmware/tags


setup_and_config() {
  home=$1
  
  info "Running setup with LATEST qmk version. See below if this is not working with existing files."
  qmk setup --home "$home"/$ROOT1
  
  info "Linking config for atreus"
  rm -rf   "$home"/"$ATREUS"
  mkdir -p "$home"/"$ATREUS"
  link_public_resource "./qmk/common/keymap_common.c"     "$home"/"$ATREUS"/keymap_common.c
  link_public_resource "./qmk/common/dicts.def"            "$home"/"$ATREUS"/dicts.def
  link_public_resource "./qmk/common/config.h"             "$home"/"$ATREUS"/config.h
  link_public_resource "./qmk/keyboardio_atreus/atreus.c"  "$home"/"$ATREUS"/atreus.c
  link_public_resource "./qmk/keyboardio_atreus/keymap.c"  "$home"/"$ATREUS"/keymap.c
  link_public_resource "./qmk/keyboardio_atreus/rules.mk"  "$home"/"$ATREUS"/rules.mk
  link_secret_resource "qmk/common/combos.def"             "$home"/"$ATREUS"/combos.def
    
  info "Linking config for ergodox_ez"
  rm -rf   "$home"/"$ERGODOX"
  mkdir -p "$home"/"$ERGODOX"
  link_public_resource "./qmk/common/keymap_common.c"      "$home"/"$ERGODOX"/keymap_common.c
  link_public_resource "./qmk/common/keymap_lights.c"      "$home"/"$ERGODOX"/keymap_lights.c
  link_public_resource "./qmk/common/dicts.def"            "$home"/"$ERGODOX"/dicts.def
  link_public_resource "./qmk/common/config.h"             "$home"/"$ERGODOX"/config.h
  link_public_resource "./qmk/ergodox_ez_glow/ergodox.c"   "$home"/"$ERGODOX"/ergodox.c
  link_public_resource "./qmk/ergodox_ez_glow/keymap.c"    "$home"/"$ERGODOX"/keymap.c
  link_public_resource "./qmk/ergodox_ez_glow/rules.mk"    "$home"/"$ERGODOX"/rules.mk
  link_secret_resource "qmk/common/combos.def"             "$home"/"$ERGODOX"/combos.def
  
  info "run 'qmk list-keyboards' to see all supported keyboards. Here are the first 20:"
  qmk list-keyboards 2>&1 | head -n 20
  qmk config user.keymap=rwijtvliet
  todo "To compile the ergodox, use 'qmk compile -kb ergodox_ez/glow -km rwijtvliet"
  todo "To compile the atreus, use 'qmk compile -kb keyboardio/atreus -km rwijtvliet"
  todo "To flash the compiled file to the keyboard, replace 'compile' with 'flash'"
  info "Let's try compiling our ergodox keymap:"
  try "qmk compile -kb ergodox_ez/glow -km rwijtvliet"
  info "Let's try compiling our atreus keymap:"
  try "qmk compile -kb keyboardio/atreus -km rwijtvliet"

  todo "If this was not successful, try setting up qmk using the branch that was used and working last time. Use the following command: 'qmk setup --home "$home"/$ROOT1 --branch $LAST_SUCCESSFUL_QMK_TAG' "
}

setup_and_config2() {
  home=$1
  
  info "Installing ZSA fork of qmk."
  git clone http://www.github.com/zsa/qmk_firmware "$home"/"$ROOT2"
  cd "$home"/"$ROOT2"
  make git-submodule
  
  info "Linking config for voyager"
  rm -rf   "$home"/"$VOYAGER"
  mkdir -p "$home"/"$VOYAGER"
  link_public_resource "./qmk/common/keymap_common.c"      "$home"/"$VOYAGER"/keymap_common.c
  link_public_resource "./qmk/common/keymap_lights.c"      "$home"/"$VOYAGER"/keymap_lights.c
  link_public_resource "./qmk/common/dicts.def"            "$home"/"$VOYAGER"/dicts.def
  link_public_resource "./qmk/common/config.h"             "$home"/"$VOYAGER"/config.h
  link_public_resource "./qmk/zsa_voyager/voyager.c"       "$home"/"$VOYAGER"/voyager.c
  link_public_resource "./qmk/zsa_voyager/keymap.c"        "$home"/"$VOYAGER"/keymap.c
  link_public_resource "./qmk/zsa_voyager/rules.mk"        "$home"/"$VOYAGER"/rules.mk
  link_secret_resource "qmk/common/combos.def"             "$home"/"$VOYAGER"/combos.def
  
  todo "To compile the voyager, use 'qmk compile -kb voyager -km rwijtvliet"
  todo "To flash the compiled file to the keyboard, replace 'compile' with 'flash'"
  info "Let's try compiling our voyager keymap:"
  try "cd $home/$ROOT2 && qmk compile -kb voyager -km rwijtvliet"

  todo "If this was not successful, ask the guys at zsa what's wrong."
}
case "$OS" in
  "linux" )
    info "Installing app"
    python3 -m pip install --user qmk
    setup_and_config $HOME
    setup_and_config2 $HOME
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
    setup_and_config2 $HOME
    ;;
    
  * )
    ;;
esac
