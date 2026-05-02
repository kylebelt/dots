#!/usr/bin/env bash
# Converts a number to nerd font icons
# Usage: custom-number.sh <number> [style]
# Styles: digital, fsquare, hsquare, dsquare, roman, super, sub, none

ID=$1
FORMAT=${2:-fsquare}

format_none="0123456789"
format_digital="🯰🯱🯲🯳🯴🯵🯶🯷🯸🯹"
format_fsquare="󰎡󰎤󰎧󰎪󰎭󰎱󰎳󰎶󰎹󰎼"
format_hsquare="󰎣󰎦󰎩󰎬󰎮󰎰󰎵󰎸󰎻󰎾"
format_dsquare="󰎢󰎥󰎨󰎫󰎲󰎯󰎴󰎷󰎺󰎽"
format_roman=" 󱂈󱂉󱂊󱂋󱂌󱂍󱂎󱂏󱂐"
format_super="⁰¹²³⁴⁵⁶⁷⁸⁹"
format_sub="₀₁₂₃₄₅₆₇₈₉"
format_block="󰿩󰬺󰬻󰬼󰬽󰬾󰬿󰭀󰭁󰭂"
format_circle="󰿬󰲠󰲢󰲤󰲦󰲨󰲪󰲬󰲮󰲰"

format="$(eval echo \"\$format_${FORMAT}\")"
[ -z "$format" ] && {
  echo "$ID"
  exit
}

for ((i = 0; i < ${#ID}; i++)); do
  DIGIT=${ID:i:1}
  echo -n "${format:DIGIT:1}"
done
