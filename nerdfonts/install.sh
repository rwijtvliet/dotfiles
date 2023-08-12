#!/bin/bash

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
      if ! wget -q "$download_url"; then
        fail "Could not download font archive $download_url (file not found?)"
      else
      	filesize=$(numfmt --to=iec-i --suffix=B --format="%.0f" $(stat --printf="%s" "$zipfile"))
        unzip -qqu "$zipfile" *.[to]tf -d "$fontdir"
        rm "$zipfile"
      	success "Extracted fonts in $filesize archive $download_url to $fontdir"
      fi
  done

  find "$fontdir" -type f ! -iname '*mono*' -delete

  # remove temp folder
  cd ..
  rm -rf ./tmp
}

case "$OS" in
  "linux" )
    download_fonts
    # find "$HOME/fonts" -name '*Windows Compatible*' -delete

		#'install'
    cp "$HOME/fonts/"* "$HOME/.local/share/fonts/"

 
    rm -rf "$HOME/fonts/"
    fc-cache -fv
    ;;

  "windows" )
    download_fonts 
    
    todo "Fonts must still be installed manually. The can be found in $HOME/fonts"
    ;;

  * )
    ;;
esac
