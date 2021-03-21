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

obj "tour" "computer" 512
obj "ordi_et_ombre" "monitor" 512
obj "bureau_et_ombre" "desk" 1024
obj "cables" "cables"

mkdir -p assets/drawers
for (( i=1; i<=5; i++ )); do
    gen "main" "tiroir_${i}_ouvert" "assets/drawers/$i-open.png"
    gen "main" "tiroir_$i" "assets/drawers/$i-closed.png"
done
gen "main" "tirroir_plein" "assets/drawers/inspected.png" 1024

mkdir -p assets/screens
gen "main" "ecran_1" "assets/screens/screen-off.png" 512
gen "main" "ecran_2_plein" "assets/screens/screen-on.png" 512
mkdir -p assets/screens/icons
gen "main" "tournevis" "assets/screens/icons/settings.png" 64

mkdir -p assets/totem
obj "statue_vide" "totem"
gen "main" "lune" "assets/totem/moon.png"
gen "main" "etoile" "assets/totem/star.png"
gen "main" "croix" "assets/totem/cross.png"
gen "main" "lune_vide" "assets/totem/moon_placeholder.png" 64
gen "main" "etoile_vide" "assets/totem/star_placeholder.png" 64
gen "main" "croix_vide" "assets/totem/cross_placeholder.png" 64

mkdir -p assets/clock
obj "horloge_et_trous" "clock"
gen "main" "fond_horloge_et_trous" "assets/clock/clock_lever_background.png"
gen "main" "levier" "assets/clock/lever.png" 128
gen "main" "horloge_heure" "assets/clock/clock_settings.png" 1024
gen "main" "aiguille_1" "assets/clock/clock_minutes.png" 128
gen "main" "aiguille_2" "assets/clock/clock_hours.png" 128
gen "main" "aiguille_3" "assets/clock/clock_seconds.png" 128
gen "main" "bouton_1_1_ouvert" "assets/clock/time_up.png"
gen "main" "bouton_2_2_ouvert" "assets/clock/time_down.png"
gen "main" "bouton_heure_ferme" "assets/clock/time_up_pressed.png"
gen "main" "bouton_2_ferme" "assets/clock/time_down_pressed.png"
gen "main" "vis_1" "assets/clock/screw.png" 64

mkdir -p assets/panel
obj "tapis" "carpet" 1024 512
gen "main" "sous_tapis_plein" "assets/panel/panel_board.png" 1024 1024
gen "main" "ombre_sous_tapis_ouvert" "assets/panel/panel_board_shadow.png" 1024 256
gen "main" "batteries_pleines" "assets/panel/batteries_full.png"
gen "main" "batteries_vides" "assets/panel/batteries_empty.png"
gen "main" "tirroir_tapis" "assets/panel/locker.png"
gen "main" "bouton_tapis_ouvert" "assets/panel/play_button.png" 64
gen "main" "bouton_tapis_ferme" "assets/panel/play_button_pressed.png" 64

mkdir -p assets/panel/radio
gen "main" "fond_bouton_radio" "assets/panel/radio/background.png" 1024
for (( i=1; i<=9; i++ )); do
    gen "main" "bouton_radio_ouvert_$i" "assets/panel/radio/button-$i.png" 256 96
    gen "main" "bouton_radio_ferme_$i" "assets/panel/radio/button-$i-pressed.png" 256 96
done

mkdir -p assets/painting/icons
gen "main" "sous_tableau" "assets/painting/painting_back.png" 512
gen "main" "icone_san_marino" "assets/painting/icons/1.png" 128
gen "main" "icone_domagano" "assets/painting/icons/2.png" 128
gen "main" "icone_borgo_maggiorre" "assets/painting/icons/3.png" 128
gen "main" "bouton_tableau_ferme" "assets/painting/button-pressed.png" 256 96
gen "main" "bouton_tableau_ouvert" "assets/painting/button.png" 256 96
gen "main" "ecran_tableau_1" "assets/painting/screen-default.png" 256 96
gen "main" "ecran_tableau_2" "assets/painting/screen-wrong.png" 256 96
gen "main" "ecran_tableau_3" "assets/painting/screen-good.png" 256 96

mkdir -p assets/books
gen "main" "livre_magique" "assets/books/magic_book.png" 128
gen "main" "bible" "assets/books/bible.png" 128
gen "main" "interieur_livre_musique" "assets/books/page_hits.png" 1024
gen "main" "interieur_bible" "assets/books/page_bible.png" 1024
gen "main" "interrieur_livre_san_marino" "assets/books/page_castles.png" 1024

mkdir -p assets/panel/diodes
for (( i=1; i<=3; i++ )); do
    gen "main" "diode_r_$i" "assets/panel/diodes/off-$i.png" 64
    gen "main" "diode_v_$i" "assets/panel/diodes/on-$i.png" 64
done

mkdir -p assets/ui/buttons
buttons="partir,exit;option,settings;jouer,play"
for button in $(IFS=';'; echo $buttons); do
    IFS=',' read -r -a names <<< $button
    gen "main" "bouton_${names[0]}_ouvert" "assets/ui/buttons/${names[1]}.png"
    gen "main" "bouton_${names[0]}_ferme" "assets/ui/buttons/${names[1]}_pressed.png"
done

# Background

gen "main" "sol_mur_et_ombre" "assets/background.png" 1920 1080

# UI

mkdir -p assets/cursor
gen "hands" "main_ouverte" "assets/cursor/cursor_default.png" 256
gen "hands" "main_ferme" "assets/cursor/cursor_grab.png" 256
