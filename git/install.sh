#!/bin/bash

source ../shared.sh

link_file "./gitconfig.symlink" "$HOME/.gitconfig"
link_file "./gitconfig.local.private" "$HOME/.gitconfig.local"
