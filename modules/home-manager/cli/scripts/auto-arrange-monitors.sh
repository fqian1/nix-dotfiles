#!/bin/bash

OUTPUTS=$(wlr-randr | awk '
    /^[A-Za-z0-9-]+/ { name = $1 }
    /Enabled: yes/ { print name }
')

if [ -z "$OUTPUTS" ]; then
    echo "No active Wayland outputs found using wlr-randr. Exiting."
    exit 1
fi

COMMAND="wlr-randr"
PREVIOUS_OUTPUT=""

for CURRENT_OUTPUT in $OUTPUTS; do
    echo "Processing output: $CURRENT_OUTPUT"
    COMMAND="$COMMAND --output $CURRENT_OUTPUT"

    if [ ! -z "$PREVIOUS_OUTPUT" ]; then
        COMMAND="$COMMAND --left-of $PREVIOUS_OUTPUT"
    fi
    PREVIOUS_OUTPUT=$CURRENT_OUTPUT
done

echo "$COMMAND"
