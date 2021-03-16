#!/bin/sh
# Ilmank (GWJ31) assets export script to extract eleemnts from messy input svg file

function obj {
    inkscape --export-type=svg --export-filename="$2.svg" --export-id="$1" ilmank-decoration.svg
    echo "Exported file '$1'!"
}

obj "lamp" "assets/objects/lamp"
obj "shelf" "assets/objects/shelf"

