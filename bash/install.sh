#!/usr/bin/env bash

source ../shared.sh

link_file "./bashrc.symlink" "$HOME/.bashrc"
link_file "./bash_aliases.symlink" "$HOME/.bash_aliases"
link_file "./bash_exports.private" "$HOME/.bash_exports"

case "$OS" in
  "linux" )
    link_file ./bash_osspecific_linux.symlink $HOME/.bash_osspecific
    ;;

  "windows" )
    ;;

  "macos" )
    link_file ./bash_osspecific_macos.symlink $HOME/.bash_osspecific
    ;;

  * )
    ;;
esac
