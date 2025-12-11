#!/bin/bash

if ! command -v jq &> /dev/null; then
    echo "jq not found"
    exit 1
fi

JSON_FILE="$1"

if [ -z "$JSON_FILE" ]; then
    echo "Usage: $0 <path_to_json>"
    exit 1
fi

COLORS=$(jq -r 'to_entries | .[] | .key + "=" + .value' "$JSON_FILE")

get_hex() {
    local key="$1"
    echo "$COLORS" | grep "^$key=" | cut -d'=' -f2
}

set_ansi() {
    local index=$1
    local key=$2
    local hex=$(get_hex "$key")

    if [ -n "$hex" ]; then
        printf "\033]4;%d;#%s\007" "$index" "$hex"
    fi
}

set_ansi 0  "base00" 
set_ansi 1  "base08" 
set_ansi 2  "base0B" 
set_ansi 3  "base0A" 
set_ansi 4  "base0D" 
set_ansi 5  "base0E" 
set_ansi 6  "base0C" 
set_ansi 7  "base05" 

set_ansi 8  "base03" 
set_ansi 9  "base09" 
set_ansi 10 "base01" 
set_ansi 11 "base02" 
set_ansi 12 "base04" 
set_ansi 13 "base06" 
set_ansi 14 "base0F" 
set_ansi 15 "base07" 

clear
