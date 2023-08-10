#!/bin/bash

source ./shared.sh

cd "$(dirname "$0")"
DOTFILES_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

successful=()
failure=()

for foldername in $(cat "$DOTFILES_ROOT/order")
do
  echo ''

  success   "┌── $foldername ─── start ────┐"
  
  cd "$DOTFILES_ROOT/$foldername"
  ./install.sh
  if [ $? -eq 0 ]
  then
    success "└── $foldername ─── \033[0;32msuccess\033[0m ──┘"
    successfully+=("$foldername")
  else
    fail    "└── $foldername ─── \033[0;31merror\033[0m ────┘"
    failure+=("$foldername")
  fi
done

# Summary

echo ''
echo ''
echo "Summary: successfully finished"
for foldername in "${successfully[@]}"
do
  success "$foldername"
done
echo "Summary: ran into error"
for foldername in "${failure[@]}"
do
  fail "$foldername"
done
echo "Check for files/folders to create"
todo "In output above, check for lines starting with [\033[0;36m\033[1mTODO\033[0m]. They indicate to-do items, like (private) files or folders that must still be created."
