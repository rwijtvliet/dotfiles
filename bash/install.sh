#!/bin/bash

source ../shared.sh

overwrite_all=false backup_all=false skip_all=false

link_file "./bashrc.symlink" "$HOME/.bashrc"
link_file "./bash_aliases_general.symlink" "$HOME/.bash_aliases_general"
link_file ./bash_exports.private $HOME/.bash_exports

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
