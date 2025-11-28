#!/bin/sh

OUTPUTS=$(wlr-randr | awk '
    /^[A-Za-z0-9-]+/ { name = $1 }
    /Enabled: yes/ { print name }
')

if [ -z "$OUTPUTS" ]; then
    exit 1
fi

COMMAND="wlr-randr"
PREVIOUS_OUTPUT=""

for CURRENT_OUTPUT in $OUTPUTS; do
    COMMAND="$COMMAND --output $CURRENT_OUTPUT"

    if [ ! -z "$PREVIOUS_OUTPUT" ]; then
        COMMAND="$COMMAND --left-of $PREVIOUS_OUTPUT"
    fi
    PREVIOUS_OUTPUT=$CURRENT_OUTPUT
done

$COMMAND
