#!/bin/sh
# Ilmank (GWJ31) assets export script to extract elements from messy input svg file

TO_EXPORT=${1:-".+"}

rm -rf gen-input
mkdir gen-input
touch gen-input/.gdignore
echo "(Init) Cleaned 'gen-input'."

git show assets:ilmank-decoration.svg > gen-input/main.svg
git show assets:ilmank-main.svg > gen-input/hands.svg

function ceil {
    python -c "from math import ceil; print(ceil($1))"
}

# this function is a mess but whatever
function gen {
    local input="gen-input/$1.svg"
    local id="$2"
    local out_file="$3"
    if [[ ! $id =~ $TO_EXPORT ]]; then
        echo "Ignored file '$out_file' ($id)."
        return
    fi

    local target_width=${4:-256}
    local target_height="${5:-$target_width}"
    local max_required=$(( target_width > target_height ? target_width : target_height ))

    echo "(Progress) [$id] Exporting '$out_file'"
    local width=$(ceil $(inkscape --query-id="$id" --query-width "$input"))
    local height=$(ceil $(inkscape --query-id="$id" --query-height "$input"))
    if (( width > height )); then
        args="--export-width=$max_required"
    else
        args="--export-height=$max_required"
    fi

    if inkscape --export-filename="$out_file" --export-id="$id" --export-id-only $args "$input" &> /dev/null; then
        echo "(Progress) [$id] Exported file '$out_file'."
        local size="${target_width}x${target_height}"
        convert "$out_file" -thumbnail "$size" -background none -gravity center -extent "$size" "$out_file"
        echo "(Progress) [$id] Resized file '$out_file'."
    else
        echo "(FAIL) [$id] Cannot export file '$out_file'!"
    fi
}

function obj {
    gen "main" "$1" "assets/objects/$2.png" $3 $4
}

# Objects

mkdir -p assets/objects
obj "bibliotheque" "shelf" 1024
obj "tableau" "painting" 512
obj "lampe" "lamp"
obj "horloge" "clock"
obj "tapis" "carpet" 1024 512

obj "ordi_et_ombre" "computer" 512
obj "pasu_1" "desk" 1024
obj "cables" "cables"

mkdir -p assets/drawers
for (( i=1; i<=5; i++ )); do
    gen "main" "tiroir_${i}_ouvert" "assets/drawers/$i-open.png"
    gen "main" "tiroir_$i" "assets/drawers/$i-closed.png"
done

mkdir -p assets/screens
for (( i=1; i<=1; i++ )); do
    gen "main" "ecran_$i" "assets/screens/screen-$i.png" 512
done

# Background

gen "main" "facade_et_sol" "assets/background.png" 1920 1080

# UI

mkdir -p assets/cursor
gen "hands" "main_ouverte" "assets/cursor/cursor_default.png" 256
gen "hands" "main_ferme" "assets/cursor/cursor_grab.png" 256
