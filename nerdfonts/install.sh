#!/usr/bin/env bash

source ../shared.sh

# fonts to install
# version="v3.4.0"
declare -a fonts=(
  # AurulentSansMono
  # BitstreamVeraSansMono
  # CodeNewRoman
  # Cousine
  # DejaVuSansMono
  # DroidSansMono
  # FantasqueSansMono
  # FiraCode
  # Gohu
  # Hack
  # Hasklig
  # HeavyData
  # Hermit
  # iA-Writer
  # IBMPlexMono
  # Inconsolate
  # InconsolataGo
  # InconsolataLGC
  # Iosevka
  JetBrainsMono
  # Lekton
  # LiberationMono
  # Lilex
  # Meslo
  # Monofur
  # Mononoki
  # Monoid
  # NerdFontsSymbolsOnly
  # OpenDyslexic
  # Overpass
  # ProFont
  # ProggyClean
  # RobotoMono
  # ShareTechMono
  # Terminus
  # Tinos
  # Ubuntu
  # UbuntuMono
  # VictorMono
)

download_fonts() {
  fontdir="$HOME/fonts/"
  mkdir -p "$fontdir"

  # create and prepare folders
  rm -rf /tmp/fonts # remove possible previous downloads
  mkdir /tmp/fonts
  cd /tmp/fonts

  # download and extract the fonts
  for font in "${fonts[@]}"; do
    tarfile="${font}.tar.xz"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$tarfile"
    target_path="/tmp/fonts/$tarfile"
    if ! curl -fL "$download_url" -o "$target_path"; then
      fail "Could not download font archive $download_url (file not found?)"
    else
      filesize=$(numfmt --to=iec-i --suffix=B --format="%.0f" $(stat --printf="%s" "$target_path"))
      tar -xvf "$target_path" --wildcards --no-anchored '*.ttf' '*.otf' -C "$fontdir"
      success "Extracted fonts in $filesize archive $download_url to $fontdir"
    fi
  done

  # remove temp folder
  rm -rf /tmp/fonts/
}

case "$OS" in
"linux")
  download_fonts
  # find "$HOME/fonts" -name '*Windows Compatible*' -delete

  #'install'
  mkdir -p "$HOME/.local/share/fonts/"
  cp "$HOME/fonts/"* "$HOME/.local/share/fonts/"
  rm -rf "$HOME/fonts/"
  fc-cache -fv
  ;;

"windows")
  scoop bucket add nerd-fonts
  scoop install Hack-NF
  ;;

"macos")
  download_fonts

  #'install'
  mkdir -p "$HOME/Library/Fonts/"
  cp "$HOME/fonts/"* "$HOME/Library/Fonts/"
  rm -rf "$HOME/fonts/"
  ;;

*) ;;
esac
