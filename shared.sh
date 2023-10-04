#!/usr/bin/env bash

# General functions and variables used in other scripts.


# set -e

#colors
R='\033[0;31m'  # red
G='\033[0;32m'  # green 
X='\033[0;37m\033[1m' #gray bold
A='\033[0;36m\033[1m' #cyan bold
Y='\033[0;33m' #yellow
B='\033[00;34m' #blue
N='\033[0m'
  

info () {
  printf "\r  [${B} .. ${N}] $1\n"
}

user () {
  printf "\r  [${Y} ?? ${N}] $1\n"
}

success () {
  printf "\r\033[2K  [${G} OK ${N}] $1\n"
}

fail () {
  printf "\r\033[2K  [${R}FAIL${N}] $1\n"
}

todo () {
  printf "\r\033[2K  [${A}TODO${N}] $1\n"
}

skip () {
  printf "\r\033[2K  [${X}SKIP${N}] Not installed on $OS\n"
}

try () {
  if $1 ; then
    success "OK"
  else
    fail "FAIL"
  fi
}

overwrite_all=false backup_all=false skip_all=false

ROOT="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
SECRETDIR="$(realpath "$HOME")/.secrets"
SECRETDIR_TMPL="$ROOT/secrets"

link_secret_resource() {
  # Create link to secret file or dir. 
  #
  # Usage: link_secret_resource "git_password" "$HOME/.git_password"
  #
  # Does two things:
  # - Creates link from specified source name (=first arg) in the SECRETDIR to 
  #   the specified destination path (=second arg). The source may or may not exist yet.
  # - Creates an empty file with the source name (=first arg) in the SECRETDIR_TEMPLATE,
  #   so that the user is aware which file/folder he must create in the SECRETDIR. (Only
  #   if nothing exists at that path.)
  local src_name="$1"
  local dst_path="$(realpath -s $2)"

  # Create link.
  local src_path="$SECRETDIR/$src_name" 
  link_resource "$src_path" "$dst_path"

  # Notify user if source must still be created.
  if [ ! -f "$src_path" ] && [ ! -d "$src_path" ] && [ ! -L "$src_path" ]; then
    todo "Source file or folder [$src_path] does not exist and must be created, or copied or linked from elsewhere."
  fi

  # Create empty file in template if not yet existing.
  local src_path_tmpl="$SECRETDIR_TMPL/$src_name"
  mkdir -p "$(dirname "$src_path_tmpl")"
  if [ ! -f "$src_path_tmpl" ] && [ ! -d "$src_path_tmpl" ] && [ ! -L "$src_path_tmpl" ]; then
    touch "$src_path_tmpl"
  fi
}

link_public_resource() {
  # Create link to public file or dir.
  #
  # Usage: link_public_resource "./git_config" "$HOME/.git_config"
  #
  # Creates link from specified source path (=first arg) to the specified destination
  # path (=second arg). The source must exist.
  local src_path="$(realpath -s $1)"  # create absolute paths
  local dst_path="$(realpath -s $2)"  # create absolute paths  
  
  # Ensure source exists (or warn).
  if [ ! -f "$src_path" ] && [ ! -d "$src_path" ] && [ ! -L "$src_path" ]; then
    fail "source $src_path does not exist"
    exit 1
  fi

  link_resource "$src_path" "$dst_path"
}

link_resource () {
  # Creates link from source path (=first arg) to destination path (=second arg).
  local src="$1"
  local dst="$2"

  local overwrite= backup= skip=
  local action=

  # Ensure symlinks can be made.
  if [ "$OS" == "windows" ]; then
    export MSYS=winsymlinks:nativestrict 
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
    sudo mkdir -p "$(dirname "$dst")"
    if sudo ln -s "$src" "$dst"; then
      success "linked [$src] -> [$dst]"
    else
      fail "could not link [$src] -> [$dst]"
      exit 1
    fi
  fi
}


OS_long="$(uname -a)"
if [[ "${OS_long,,}" == *"gnu/linux"* ]]; then
  OS="linux"
elif [[ "${OS_long,,}" == *"mingw"* ]]; then
  OS="windows"
elif [[ "${OS_long,,}" == *"darwin"* ]]; then
  OS="macos"
else
  fail "unknown operating system. Value of 'uname --all' is $OS_long"
  exit 1
fi
