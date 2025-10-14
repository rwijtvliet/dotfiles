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
    if [ $(cat /usr/share/i18n/SUPPORTED | grep en_ZZ | wc -l) -gt 0 ]; then
      info "en_ZZ already in file"
    else
      info "write en_ZZ to file"
      echo 'en_ZZ UTF-8' | sudo tee -a /usr/share/i18n/SUPPORTED
    fi
    if [ $(cat /etc/locale.gen | grep en_ZZ | wc -l) -gt 0 ]; then
      info "en_ZZ already in file"
    else
      info "write en_ZZ to file"
      echo 'en_ZZ.UTF-8 UTF-8' | sudo tee -a /etc/locale.gen
    fi
    
    info "Generating locales - en_ZZ should be in this list"
    sudo locale-gen en_ZZ.UTF-8
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
