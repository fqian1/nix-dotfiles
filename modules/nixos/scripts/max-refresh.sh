#!/bin/sh

get_max_refresh_mode() {
    local output="$1"
    wlr-randr | awk -v out="$output" '
        # 1. Find the specific output block
        $1 == out { in_output = 1 }

        # 2. If we hit a new output (line starts with non-space and isnt our output), stop
        /^[^ ]/ && $1 != out { in_output = 0 }

        # 3. Find the "Modes:" section
        in_output && /Modes:/ { in_modes = 1; next }

        # 4. If inside modes, but line doesnt start with a number, stop processing modes
        in_modes && $1 !~ /^[0-9]/ { in_modes = 0 }

        # 5. Process actual mode lines
        in_modes {
            current_line = $0
            # Iterate through fields to find "Hz"
            for (i = 1; i <= NF; i++) {
                if ($i == "Hz") {
                    # The frequency is the field BEFORE "Hz"
                    freq = $(i-1)
                    if (freq > max) {
                        max = freq
                        best = current_line
                    }
                }
            }
        }
        END { if (best != "") print best }
    '
}

OUTPUTS=$(wlr-randr | awk '
    /^[A-Za-z0-9-]+/ { name = $1 }
    /Enabled: yes/ { print name }
')

for OUTPUT in $OUTPUTS; do
    MODE_LINE=$(get_max_refresh_mode "$OUTPUT")

    if [ -z "$MODE_LINE" ]; then
        echo "No modes found for $OUTPUT. Skipping."
        continue
    fi

    # Extract Resolution ($1) and Frequency (Field before "Hz")
    MODE=$(echo "$MODE_LINE" | awk '{ for(i=1;i<=NF;i++) if($i=="Hz") print $1 "@" $(i-1) }')

    if [ -z "$MODE" ]; then
        echo "Could not parse mode for $OUTPUT. Skipping."
        continue
    fi

    echo "Setting $OUTPUT to max refresh: $MODE"
    wlr-randr --output "$OUTPUT" --mode "$MODE"
done
