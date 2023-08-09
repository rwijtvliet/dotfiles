#!/bin/bash

source ../shared.sh

link_file "./bashrc.symlink" "$HOME/.bashrc"
link_file "./bash_aliases_general.symlink" "$HOME/.bash_aliases_general"
link_file "./bash_exports.private" "$HOME/.bash_exports"
link_file "./bash_remove.private" "$HOME/.bash_remove"

case "$OS" in
  "linux" )
    link_file ./bash_aliases_os_linux.symlink $HOME/.bash_aliases_os
    ;;

  "windows" )
    # no windows-specific aliases
    ;;

  * )
    ;;
esac
