#!/bin/bash

source ./shared.sh

cd "$(dirname "$0")"
DOTFILES_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

successful=()
failure=()

for foldername in $(cat $DOTFILES_ROOT/order)
do
  echo ''

  success "┌── $foldername installation started ────┐"
  
  cd "$DOTFILES_ROOT/$foldername"
  ./install.sh
  if [ $? -eq 0 ]
  then
    success "└── $foldername installed successfully ──┘"
    successfully+=("$foldername")
  else
    fail "└── $foldername finished with error ─────┘"
    failure+=("$foldername")
  fi
done

# Summary

echo ''
echo ''
echo "Summary: correctly installed"
for foldername in "${successfully[@]}"
do
  success "$foldername"
done
echo "Summary: installation failed"
for foldername in "${failure[@]}"
do
  fail "$foldername"
done
echo "Check for files/folders to create"
warn "In output above, check for lines starting with [\033[0;36m\033[1m !! \033[0m]. They indicate (private) files or folders must still be created."
