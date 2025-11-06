#!/usr/bin/env bash

source ../shared.sh

# fonts to install
version="v3.0.2"
declare -a fonts=(
	Agave
	AurulentSansMono
	BitstreamVeraSansMono
	CodeNewRoman
	Cousine
	DejaVuSansMono
	DroidSansMono
	FantasqueSansMono
	FiraCode
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



download_fonts () {
  fontdir="$HOME/fonts/"

  # create and prepare folders 
	rm -rf ./tmp # remove possible previous downloads
	mkdir ./tmp
  cd ./tmp
  mkdir -p "$fontdir"

	# download and extract the fonts
  for font in "${fonts[@]}"; do
      zipfile="${font}.zip"
      download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/$version/$zipfile"
      download_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$zipfile"
      if ! curl -q "$download_url"; then
        fail "Could not download font archive $download_url (file not found?)"
      else
      	filesize=$(numfmt --to=iec-i --suffix=B --format="%.0f" $(stat --printf="%s" "$zipfile"))
        unzip -qqu "$zipfile" *.[to]tf -d "$fontdir"
        rm "$zipfile"
      	success "Extracted fonts in $filesize archive $download_url to $fontdir"
      fi
  done

  # remove temp folder
  cd ..
  rm -rf ./tmp
}

case "$OS" in
  "linux" )
    download_fonts
    # find "$HOME/fonts" -name '*Windows Compatible*' -delete

		#'install'
    mkdir -p "$HOME/.local/share/fonts/"
    cp "$HOME/fonts/"* "$HOME/.local/share/fonts/"
    rm -rf "$HOME/fonts/"
    fc-cache -fv
    ;;

  "windows" )
    scoop bucket add nerd-fonts
    scoop install Hack-NF    
    ;;

	"macos" )
  	download_fonts

  	#'install'
    mkdir -p "$HOME/Library/Fonts/"
  	cp "$HOME/fonts/"* "$HOME/Library/Fonts/"
    rm -rf "$HOME/fonts/"
		;;
		
  * )
    ;;
esac
