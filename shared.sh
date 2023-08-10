#!/bin/bash

# General functions and variables used in other scripts.


# set -e



info () {
  printf "\r  [\033[00;34m .. \033[0m] $1\n"
}

user () {
  printf "\r  [\033[0;33m ?? \033[0m] $1\n"
}

success () {
  printf "\r\033[2K  [\033[00;32m OK \033[0m] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
}

todo () {
  printf "\r\033[2K  [\033[0;36m\033[1mTODO\033[0m] $1\n"
}

skip () {
  printf "\r\033[2K  [\033[0;37m\033[1mSKIP\033[0m] Not installed on $OS\n"
}


overwrite_all=false backup_all=false skip_all=false


link_file () {
  local src="$(realpath -s $1)"  # create absolute paths
  local dst="$(realpath -s $2)"  # create absolute paths

  local overwrite= backup= skip=
  local action=

  # Ensure symlinks can be made.
  if [ "$OS" == "windows" ]; then
    export MSYS=winsymlinks:nativestrict 
  fi

  # Ensure source exists (or warn).
  if [ ! -f "$src" ] && [ ! -d "$src" ]; then
    
    if [[ "$src" != *".private" ]]; then
      fail "source $src does not exist"
      exit 1
    else
      todo "Source file or folder [$src] does not exist and must be created, or copied or linked from elsewhere."
      needtobecreated+=("$src")
    fi
  fi
 
  # Ensure destination not accidentally overwritten.
  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]; then
  
    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

      local currentSrc="$(readlink "$dst")"
       
      if [ "$currentSrc" == "$src" ]; then

        skip=true
        skipwhy="because the source is already correct"

      else

        if [ -f "$dst" ]; then
          exists="a regular file"
        elif [ -d "$dst" ]; then
          exists="a folder"
        else
          exists="a link to [$currentSrc]"
        fi
        user "[$dst] (= $exists) already exists, but we want to replace it with a link to [$src]. What do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
        skipwhy=""

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
      if rm -rf "$dst"; then
        success "removed $dst"
      else
        fail "could not remove $dst"
        exit 1
      fi
    fi

    if [ "$backup" == "true" ]; then
      if mv "$dst" "${dst}.backup"; then
        success "moved [$dst] to [${dst}.backup]"
      else
        fail "could not move [$dst] to [${dst}.backup]"
        exit 1
      fi
    fi

    if [ "$skip" == "true" ]; then
      success "skipped linking [$src] -> [$dst] $skipwhy"
    fi
  fi

  if [ "$skip" != "true" ]; then  # "false" or empty
    if ln -s "$src" "$dst"; then
      success "linked [$src] -> [$dst]"
    else
      fail "could not link [$src] -> [$dst]"
      exit 1
    fi
  fi
}


OS_long="$(uname --all)"
if [[ "${OS_long,,}" == *"gnu/linux"* ]]; then
  OS="linux"
elif [[ "${OS_long,,}" == *"mingw"* ]]; then
  OS="windows"
else
  fail "unknown operating system. Value of 'uname --all' is $OS_long"
  exit 1
fi
