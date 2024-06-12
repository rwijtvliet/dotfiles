#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
"linux")
	info "Removing old installation"
	rm -rf "$HOME/.local/share/nvim"
	rm -rf "$HOME/.config/nvim"

	# install nvim
	info "Installing app"
	sudo apt install ripgrep
	sudo npm install -g neovim tree-sitter-cli
	$( #run in subshell to not permanently change to that folder
		mkdir -p "$HOME/.local/bin"
		curl -Lo "$HOME/.local/bin/nvim" https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
		chmod u+x "$HOME/.local/bin/nvim"
	)
	#link_public_resource "$HOME/.local/bin/nvim" "nvim.appimage"
	# (alternative: install from apt, but often outdated)
	# sudo apt install neovim

	# needed for developing python
	pip install ueberzug cairosvg pnglatex plotly kaleido 
	
	# add user config
	info "adding user configs"
	link_public_resource "./nvim" "$HOME/.config/nvim"
	link_public_resource "./alternative_configs/lazyvim" "$HOME/.config/nvim-lazyvim"
	link_public_resource "./alternative_configs/astronvim" "$HOME/.config/nvim-astronvim"
	;;

"windows")
	info "Removing old installation"
	# TODO: where is .local/share/nvim on windows?
	rm -rf "$USERPROFILE/AppData/Local/nvim"

	# install nvim
	info "Installing app"
	scoop bucket add main
	scoop install gcc
	scoop install neovim
	
	# needed for developing python
	pip install ueberzug cairosvg pnglatex plotly kaleido

	# add user config
	info "adding user configs"
	link_public_resource "./nvim" "$USERPROFILE/AppData/Local/nvim"
	link_public_resource "./alternative_configs/lazyvim" "$USERPROFILE/AppData/Local/nvim-lazyvim"
	link_public_resource "./alternative_configs/astronvim" "$HOME/.config/nvim-astronvim"
	;;

"macos")
	info "Removing old installation"
	rm -rf "$HOME/.local/share/nvim"
	rm -rf "$HOME/.config/nvim"

	# install nvim
	info "Installing app"
	brew install neovim
	
	# needed for developing python
	pip install cairosvg pnglatex plotly kaleido
        brew install jstkdng/programs/ueberzugpp 

	# add user config
	info "adding user configs"
	link_public_resource "./nvim" "$HOME/.config/nvim"
	link_public_resource "./alternative_configs/lazyvim" "$HOME/.config/nvim-lazyvim"
	link_public_resource "./alternative_configs/astronvim" "$HOME/.config/nvim-astronvim"
	;;

*) ;;
esac
