#!/bin/sh
# Ilmank (GWJ31) assets export script to extract elements from messy input svg file

rm -rf gen-input
mkdir gen-input
touch gen-input/.gdignore
echo "(Init) Cleaned 'gen-input'."

git show assets:ilmank-decoration.svg > gen-input/main.svg

function ceil {
    python -c "from math import ceil; print(ceil($1))"
}

# this function is a mess but whatever
function obj {
    input="gen-input/main.svg"

    local id="$1"
    local out_file="assets/objects/$2.png"
    local size="${3:-64}x${4:-${3:-64}}"

    local width=$(ceil $(inkscape --query-id="$id" --query-width "$input"))
    local height=$(ceil $(inkscape --query-id="$id" --query-height "$input"))
    if (( width > height )); then
        args="--export-width=$width"
    else
        args="--export-height=$height"
    fi

    inkscape --export-filename="$out_file" --export-id="$id" --export-id-only $args gen-input/main.svg &> /dev/null
    echo "(Progress) [$id] Exported file '$out_file'."
    convert "$out_file" -thumbnail "$size" -background none -gravity center -extent "$size" "$out_file"
    echo "(Progress) [$id] Resized file '$out_file'."
}

# Objects

obj "bibliotheque" "shelf" 512
obj "lampe" "lamp"
