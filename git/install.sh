#!/usr/bin/env bash

source ../shared.sh

link_public_resource "./gitconfig.symlink" "$HOME/.gitconfig"
link_secret_resource "gitconfig_secrets.symlink" "$HOME/.gitconfig_secrets"
