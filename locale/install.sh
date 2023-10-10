#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Creating definition"
    sudo localedef -c -v -i en_ZZ -f UTF-8 en_ZZ.UTF-8 
    sudo cp en_ZZ /usr/share/i18n/locales/

    if [ $(cat /var/lib/locales/supported.d/en | grep en_ZZ | wc -l) -gt 0 ]; then
      info "en_ZZ already in file"
    else
      info "write en_ZZ to file"
      echo 'en_ZZ UTF-8' | sudo tee -a /var/lib/locales/supported.d/en
    fi
    
    info "Generating locales - en_ZZ should be in this list"
    sudo locale-gen
    info "Linking config"
    link_public_resource "./locale" "$HOME/.locale"
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
