#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
"linux")
	# Install.
	info "Installing app"
        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
        echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
	sudo apt update
	sudo apt install wezterm
        # (alternatively, flatpak. Works, but has issue figuring out which process is running https://github.com/wez/wezterm/issues/2783)
        # flatpak install flathub org.wezfurlong.wezterm
        # flatpak run org.wezfurlong.wezterm

	# Config.
	info "Linking config file"
	mkdir -p "$HOME/.config/wezterm/"
	link_public_resource "./wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
	link_public_resource "./wezterm_general.lua" "$HOME/.config/wezterm/wezterm_general.lua"
	link_public_resource "./wezterm_osspecific_linux.lua" "$HOME/.config/wezterm/wezterm_osspecific.lua"
	;;

"windows")
	# install
	info "Installing app"
	scoop bucket add extras
	scoop install wezterm 
	# config
	info "Linking config file"
	mkdir -p "$HOME/.config/wezterm/"
	link_public_resource "./wezterm.lua" "$HOME/.config/wezterm/wezterm.lua" # ... or $APPDATA ?
	link_public_resource "./wezterm_general.lua" "$HOME/.config/wezterm/wezterm_general.lua"
	link_public_resource "./wezterm_osspecific_windows.lua" "$HOME/.config/wezterm/wezterm_osspecific.lua"
	;;

"macos")
	# install
	info "Installing app"
        brew install --cask wezterm
	# config
	info "Linking config file"
	mkdir -p "$HOME/.config/wezterm/"
	link_public_resource "./wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
	link_public_resource "./wezterm_general.lua" "$HOME/.config/wezterm/wezterm_general.lua"
	link_public_resource "./wezterm_osspecific_macos.lua" "$HOME/.config/wezterm/wezterm_osspecific.lua"
	;;

*) ;;
esac
