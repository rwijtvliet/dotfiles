#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
"linux")
	# install
	info "Installing app"
        flatpak install flathub org.wezfurlong.wezterm
        flatpak run org.wezfurlong.wezterm
	# config
	info "Linking config file"
	link_public_resource "./wezterm.lua" "$HOME/.wezterm.lua"
	;;

"windows")
	# install
	info "Installing app"
	scoop bucket add extras
	scoop install wezterm 
	# config
	info "Linking config file"
	link_public_resource "./wezterm.lua" "$APPDATA/.wezterm.lua" # ... or $HOME ?
	;;

"macos")
	# install
	info "Installing app"
        brew install --cask wezterm
	# config
	info "Linking config file"
	link_public_resource "./wezterm.lua" "$HOME/.wezterm.lua"
	;;

*) ;;
esac
