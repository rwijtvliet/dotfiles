#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Creating definition"
    sudo localedef -i en_ZZ -f UTF-8 en_ZZ.UTF-8 -c -v
    sudo cp en_ZZ /usr/share/i18n/locales/
    sudo echo 'en_ZZ utf-8'>>/var/lib/locales/supported.d/en
    info "Generating locales - en_ZZ should be in this list"
    sudo locale-gen
    info "Linking config"
    link_public_resource "./locale.symlink" "$HOME/.locale"
    ;;

  "windows" )
    fail "to-do"
    exit 1
    ;;

  "macos" )
    fail "to-do"
    ;;
    
  * )
    ;;
esac
