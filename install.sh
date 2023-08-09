#!/bin/bash

source ./shared.sh

cd "$(dirname "$0")"
DOTFILES_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

successful=()
failure=()

backup_all=false overwrite_all=false skip_all=false
for foldername in $(cat $DOTFILES_ROOT/order)
do
  echo ''
  echo "backup_all = $backup_all"
  echo "overwrite_all = $overwrite_all"
  echo "skip_all = $skip_all"

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
echo 'Summary'
for foldername in "${successfully[@]}"
do
  success "$foldername"
done
for foldername in "${failure[@]}"
do
  fail "$foldername"
done
