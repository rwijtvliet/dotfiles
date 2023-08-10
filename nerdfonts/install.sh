#!/bin/bash

source ../shared.sh

# fonts to install
declare -a fonts=(
	Agave
	AnonymousPro
	AurulentSansMono
	BigBlueTerminal
	BitstreamVeraSansMono
	CodeNewRoman
	Cousine
	DaddyTimeMono
	DejaVuSansMono
	DroidSansMono
	FantasqueSansMono
	FiraCode
	Go-Mono
	Gohu
	Hack
	Hasklig
	HeavyData
	Hermit
	iA-Writer
	IBMPlexMono
	Inconsolate
	InconsolataGo
	InconsolataLGC
	Iosevka
	JetBrainsMono
	Lekton
	LiberationMono
	Lilex
	Meslo
	Monofur
	Mononoki
	Monoid
	NerdFontsSymbolsOnly
	Noto
	OpenDyslexic
	Overpass
	ProFont
	ProggyClean
	RobotoMono
	ShareTechMono
	Terminus
	Tinos
	Ubuntu
	UbuntuMono
	VictorMono
)

version="v3.0.2"


copy_fonts () {
  fontdir="$1"
  mkdir -p "$fontdir"
  for font in "${fonts[@]}"; do
      zipfile="${font}.zip"
      download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/$version/$zipfile"
      info "Installing fonts in $download_url"
      if ! wget -q "$download_url"; then
        fail "file not found"
      else
        unzip -uqq "$zipfile" *.[to]tf -d "$fontdir"
        rm "$zipfile"
      fi
  done
}

case "$OS" in
  "linux" )
  	mkdir "$HOME/downloads"
  	cd "$HOME/downloads"
    copy_fonts "$HOME/.local/share/fonts"
    find "$HOME/.local/share/fonts" -name '*Windows Compatible*' -delete
    fc-cache -fv
    ;;

  "windows" )
  	mkdir "$HOME/Downloads"
  	cd "$HOME/Downloads"
  	mkdir -p "$HOME/fonts/"
    copy_fonts "$HOME/fonts"
    todo "Fonts must still be installed manually. The can be found in $HOME/fonts"
    ;;

  * )
    ;;
esac
