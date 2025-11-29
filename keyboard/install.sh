#!/usr/bin/env bash

source ../shared.sh

SOFTWARE="$HOME/syncNone/Software_Installed"

VENV_OFFICIAL="$SOFTWARE/.venv_official_qmk_firmware"
FIRMWARE_OFFICIAL="$SOFTWARE/official_qmk_firmware"
VENV_ZSA="$SOFTWARE/.venv_zsa_qmk_firmware"
FIRMWARE_ZSA="$SOFTWARE/zsa_qmk_firmware"

ERGODOX="keyboards/ergodox_ez/keymaps/rwijtvliet"
ATREUS="keyboards/keyboardio/atreus/keymaps/rwijtvliet"
VOYAGER="keyboards/zsa/voyager/keymaps/rwijtvliet"

BINDIR="$HOME/.local/bin"

LAST_SUCCESSFUL_QMK_TAG="0.30.13"  # see https://github.com/qmk/qmk_firmware/tags


setup_and_config_official() {
  venv=$1
  firmware=$2
 
  info "Installing official (=upstream) qmk."

  info "Creating venv, install qmk, and running setup. Using latest python version."
  python3 -m venv "$venv"
  source "$venv/bin/activate"
  pip install --upgrade pip
  python3 -m pip install qmk
  deactivate

  info "Creating wrapper script in ~/.local/bin/ to call THIS qmk install with qmk_official or qmko"
  rm "$BINDIR/qmk_official" "$BINDIR/qmko"
  cat > "$BINDIR/qmk_official" <<-EOF
#!/usr/bin/env bash
export QMK_HOME="$firmware"
source "$venv/bin/activate"
qmk "\$@"
EOF
  chmod +x "$BINDIR/qmk_official"
  ln -s "$BINDIR/qmk_official" "$BINDIR/qmko"

  info "Running setup. See below if this is not working with existing files."
  qmk_official setup
  
  info "Linking config for atreus"
  rm -rf   "$firmware"/"$ATREUS"
  mkdir -p "$firmware"/"$ATREUS"
  link_public_resource "./qmk/common/keymap_common.c"             "$firmware"/"$ATREUS"/keymap_common.c
  link_public_resource "./qmk/common/dicts.def"                   "$firmware"/"$ATREUS"/dicts.def
  link_public_resource "./qmk/common/config.h"                    "$firmware"/"$ATREUS"/config.h
  link_public_resource "./qmk/keyboardio_atreus/keymap_atreus.c"  "$firmware"/"$ATREUS"/keymap_atreus.c
  link_public_resource "./qmk/keyboardio_atreus/keymap.c"         "$firmware"/"$ATREUS"/keymap.c
  link_public_resource "./qmk/keyboardio_atreus/rules.mk"         "$firmware"/"$ATREUS"/rules.mk
  link_secret_resource "qmk/common/combos.def"                    "$firmware"/"$ATREUS"/combos.def
    
  info "Linking config for ergodox_ez"
  rm -rf   "$firmware"/"$ERGODOX"
  mkdir -p "$firmware"/"$ERGODOX"
  link_public_resource "./qmk/common/keymap_common.c"             "$firmware"/"$ERGODOX"/keymap_common.c
  link_public_resource "./qmk/common/keymap_lights.c"             "$firmware"/"$ERGODOX"/keymap_lights.c
  link_public_resource "./qmk/common/dicts.def"                   "$firmware"/"$ERGODOX"/dicts.def
  link_public_resource "./qmk/common/config.h"                    "$firmware"/"$ERGODOX"/config.h
  link_public_resource "./qmk/ergodox_ez_glow/keymap_ergodox.c"   "$firmware"/"$ERGODOX"/keymap_ergodox.c
  link_public_resource "./qmk/ergodox_ez_glow/keymap.c"           "$firmware"/"$ERGODOX"/keymap.c
  link_public_resource "./qmk/ergodox_ez_glow/rules.mk"           "$firmware"/"$ERGODOX"/rules.mk
  link_secret_resource "qmk/common/combos.def"                    "$firmware"/"$ERGODOX"/combos.def
  
  info "run 'qmk_official list-keyboards' (or 'qmko' instead of 'qmk_official' for short) to see all supported keyboards. Here are the first 20:"
  qmk_official list-keyboards 2>&1 | head -n 20
  qmk_official config user.keymap=rwijtvliet
  todo "To compile the ergodox, use 'qmk compile -kb ergodox_ez/glow -km rwijtvliet"
  todo "To compile the atreus, use 'qmk compile -kb keyboardio/atreus -km rwijtvliet"
  todo "To flash the compiled file to the keyboard, replace 'compile' with 'flash'"
  info "Let's try compiling our ergodox keymap:"
  try "qmk_official compile -kb ergodox_ez/glow -km rwijtvliet"
  info "Let's try compiling our atreus keymap:"
  try "qmk_official compile -kb keyboardio/atreus -km rwijtvliet"

  todo "If this was not successful, try setting up qmk using the branch that was used and working last time. Use the following command: 'qmk_official setup --home "$firmware" --branch $LAST_SUCCESSFUL_QMK_TAG' "
}

setup_and_config_zsa() {
  venv=$1
  firmware=$2
  
  info "Installing ZSA fork of qmk."
 
  info "First clone repo (not needed for official repo, only for zsa)."
  git clone http://www.github.com/zsa/qmk_firmware "$firmware"
  git -C "$firmware" submodule update --init --recursive

  info "Creating venv, install qmk, and running setup. Using older python version, needed by zsa."
  sudo apt install python3.9 python3.9-venv python3.9-distutils
  python3.9 -m venv "$venv" 
  source "$venv/bin/activate"
  python3 -m pip install qmk
  deactivate
  
  info "Creating wrapper script in ~/.local/bin/ to call THIS qmk install with qmk_zsa or qmkz"
  rm "$BINDIR/qmk_zsa" "$BINDIR/qmkz"  
  cat > "$BINDIR/qmk_zsa" <<-EOF
#!/usr/bin/env bash
export QMK_HOME="$firmware"
source "$venv/bin/activate"
qmk "\$@"
EOF
  chmod +x "$BINDIR/qmk_zsa"
  ln -s "$BINDIR/qmk_zsa" "$BINDIR/qmkz"

  info "Running setup. See below if this is not working with existing files."
  qmk_zsa setup # uses the QMK_HOME env var set in the wrapper script

  info "Linking config for voyager"
  rm -rf   "$firmware"/"$VOYAGER"
  mkdir -p "$firmware"/"$VOYAGER"
  link_public_resource "./qmk/common/keymap_common.c"        "$firmware"/"$VOYAGER"/keymap_common.c
  link_public_resource "./qmk/common/keymap_lights.c"        "$firmware"/"$VOYAGER"/keymap_lights.c
  link_public_resource "./qmk/common/dicts.def"              "$firmware"/"$VOYAGER"/dicts.def
  link_public_resource "./qmk/common/config.h"               "$firmware"/"$VOYAGER"/config.h
  link_public_resource "./qmk/zsa_voyager/keymap_voyager.c"  "$firmware"/"$VOYAGER"/keymap_voyager.c
  link_public_resource "./qmk/zsa_voyager/keymap.c"          "$firmware"/"$VOYAGER"/keymap.c
  link_public_resource "./qmk/zsa_voyager/rules.mk"          "$firmware"/"$VOYAGER"/rules.mk
  link_secret_resource "qmk/common/combos.def"               "$firmware"/"$VOYAGER"/combos.def
  
  todo "To compile the voyager, use 'qmk_zsa compile -kb voyager -km rwijtvliet"
  todo "To flash the compiled file to the keyboard, replace 'compile' with 'flash'"
  info "Let's try compiling our voyager keymap:"
  try "qmk_zsa compile -kb voyager -km rwijtvliet"

  todo "If this was not successful, ask the guys at zsa what's wrong."
}
case "$OS" in
  "linux" )
    info "Installing app"
    setup_and_config_official "$VENV_OFFICIAL" "$FIRMWARE_OFFICIAL"
    setup_and_config_zsa "$VENV_ZSA" "$FIRMWARE_ZSA"
    ;;

  "windows" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
    ;;

  "macos" )
    info "Installing app (if not up-to-date, this will take several hours (!) on apple silicon)"
    fail "to-do"
    exit 1
    brew install qmk/qmk/qmk
    setup_and_config $HOME
    setup_and_config2 $HOME
    ;;
    
  * )
    ;;
esac
