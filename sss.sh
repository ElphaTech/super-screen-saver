#!/usr/bin/env bash

# exit when ctrl+c is pressed
trap 'tput reset && exit 0' INT

# default frame rate
FRAME_RATE=60

# Check if the 'tte' command is available
if ! command -v tte &> /dev/null; then
    echo "Error: 'tte' command not found." >&2
    echo "Please install terminaltexteffects to run this script." >&2
    echo "https://github.com/ChrisBuilds/terminaltexteffects" >&2
    exit 1
fi

# ascii-art file
input_file="logo.txt"

# Check if the input file exists and is readable
if [ ! -e "$input_file" ] || [ ! -r "$input_file" ]; then
    echo "Error: Input file '$input_file' not found or is not readable." >&2
    exit 1
fi

# grab all the effects
effects=($(tte -h | grep -E '^\s{4}[a-z]+' | awk '{print $1}'))

# loop over all the effects
while true; do
    effects_shuffled=($(shuf -e "${effects[@]}"))
    for effect in "${effects_shuffled[@]}"; do
    read -t 0.1 -n 1 key
    if [[ $key == "q" ]]; then
        exit 0
    fi
    tte -i "$input_file" --canvas-width 0 --canvas-height 0 --anchor-text c --frame-rate "$FRAME_RATE" "$effect"
    clear
    done
done