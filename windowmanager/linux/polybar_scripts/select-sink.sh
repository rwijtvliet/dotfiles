#!/usr/bin/env bash

# get current default sink numeric ID only
current=$(wpctl get-default | awk '{gsub(/\.$/,"",$1); print $1}') # first field, strip dot

# parse sinks
menu=$(wpctl status | awk '
/Sinks:/ {in_sinks=1; next}
/Sources:/ {in_sinks=0}
in_sinks && /\./ {
    line=$0
    gsub(/^│[ ]*/,"",line)

    split(line, a, ".")
    id=a[1]

    # get description
    desc=substr(line, length(a[1])+3)
    sub(/\[vol:.*\]$/,"",desc)
    gsub(/^ +| +$/,"",desc)

    # shorten names
    gsub("Tiger Lake-LP Smart Sound Technology Audio Controller ","",desc)
    if (desc ~ /HDMI \/ DisplayPort [0-9]+ Output/) {
        match(desc, /HDMI \/ DisplayPort ([0-9]+)/, m)
        desc="HDMI " m[1]
    }
    gsub("Speaker.*","Speaker",desc)
    gsub(" +$","",desc)

    print id "|" desc
}')

# show menu
choice=$(echo "$menu" | while IFS="|" read -r id name; do
  icon="󰖀"
  [[ "$name" == *HDMI* ]] && icon="󰍹"
  [[ "$name" == "Speaker" ]] && icon="󰕾"
  [[ "$name" == *Bluetooth* ]] && icon="󰂯"

  mark=""
  [ "$id" = "$current" ] && mark="*"
  # quote mark so Rofi treats it literally
  printf "%s %s %s\n" "$icon" "$name" "$mark"
done | rofi -dmenu -i -filter "" -p "Audio output")

[ -z "$choice" ] && exit

# map selection back to ID
selected=$(echo "$choice" | awk '{print $2}')
id=$(echo "$menu" | grep "|$selected$" | cut -d'|' -f1)

wpctl set-default "$id"
