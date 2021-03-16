#!/bin/sh
# Ilmank (GWJ31) assets export script to extract elements from messy input svg file

rm -rf gen-input
mkdir gen-input
touch gen-input/.gdignore
echo "(Init) Cleaned 'gen-input'."

git show assets:ilmank-decoration.svg > gen-input/main.svg

function obj {
    inkscape --export-type=svg --export-filename="$2.svg" --export-id="$1" gen-input/main.svg
    echo "(Progress) Exported file '$1'."
}

# Objects

