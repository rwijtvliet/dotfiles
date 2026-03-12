#!/usr/bin/env bash

# get current sink ID
current_id=$(wpctl get-default 2>/dev/null | awk '{print $1}' | tr -d '.')

# fallback
[ -z "$current_id" ] && echo "N/A" && exit 0

# get friendly name
wpctl status 2>/dev/null | awk -v id="$current_id" '
/Sinks:/ {in_sinks=1; next}
/Sources:/ {in_sinks=0}
in_sinks && /\./ {
    line=$0
    gsub(/^│[ ]*/,"",line)
    split(line,a,".")
    sink_id=a[1]
    desc=substr(line,length(a[1])+3)
    sub(/\[vol:.*\]$/,"",desc)
    gsub(/^ +| +$/,"",desc)

    # shorten names
    gsub("Tiger Lake-LP Smart Sound Technology Audio Controller ","",desc)
    if (desc ~ /HDMI \/ DisplayPort [0-9]+ Output/) {
        match(desc,/HDMI \/ DisplayPort ([0-9]+)/,m)
        desc="HDMI " m[1]
    }
    gsub("Speaker.*","Speaker",desc)
    gsub(" +$","",desc)

    if (sink_id == id) { print desc; exit }
}'
