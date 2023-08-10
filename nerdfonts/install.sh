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


install_fonts () {
  fontdir="$1"
  mkdir -p "$fontdir"
  for font in "${fonts[@]}"; do
      zipfile="${font}.zip"
      download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/$version/$zipfile"
      info "Installing fonts in $download_url"
      if ! wget -q "$download_url"; then
        fail "file not found"
      else
        unzip -uqqq "$zipfile" *.[to]tf -d "$fontdir"
        rm "$zipfile"
      fi
  done
}

case "$OS" in
  "linux" )
    install_fonts "$HOME/.local/share/fonts"
    find "$HOME/.local/share/fonts" -name '*Windows Compatible*' -delete
    fc-cache -fv
    ;;

  "windows" )
    install_fonts "/c/Windows/Fonts"
    ;;

  * )
    ;;
esac
