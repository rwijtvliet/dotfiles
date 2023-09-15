#!/usr/bin/env bash

source ../shared.sh

link_file "./gitconfig.symlink" "$HOME/.gitconfig"
link_file "../secrets/gitconfig_secrets.symlink" "$HOME/.gitconfig_secrets"
