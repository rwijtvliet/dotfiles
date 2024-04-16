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

	# get astronvim
	info "getting astronvim"
	git clone "https://github.com/AstroNvim/AstroNvim" "$HOME/.config/nvim"

	# add user config
	info "adding user config"
	link_public_resource "./user" "$HOME/.config/nvim/lua/user"
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

	# get astronvim
	info "getting astronvim"
	git clone "https://github.com/AstroNvim/AstroNvim" "$USERPROFILE/AppData/Local/nvim"

	# add user config
	link_public_resource "./user" "$USERPROFILE/AppData/Local/nvim/lua/user"
	;;

"macos")
	info "Removing old installation"
	rm -rf "$HOME/.local/share/nvim"
	rm -rf "$HOME/.config/nvim"

	# install nvim
	info "Installing app"
	brew install neovim

	# get astronvim
	info "getting astronvim"
	git clone "https://github.com/AstroNvim/AstroNvim" "$HOME/.config/nvim"

	# add user config
	info "adding user config"
	link_public_resource "./user" "$HOME/.config/nvim/lua/user"
	;;

*) ;;
esac
