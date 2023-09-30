#!/usr/bin/env bash

source ../shared.sh

link_public_resource "./gitconfig" "$HOME/.gitconfig"
link_secret_resource "gitconfig_secrets" "$HOME/.gitconfig_secrets"
