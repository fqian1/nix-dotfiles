# Configuration not done through Home manager, but in the overlay
{
  config,
  pkgs,
  ...
}: let
  wlrRandr = "${pkgs.wlr-randr}/bin/wlr-randr";

  maxRefreshScript = ''
    #!/bin/bash

    # Return the *exact* mode string with the highest refresh rate for a given output
    get_max_refresh_mode() {
        local output="$1"
        ${wlrRandr} | awk -v out="$output" '
            # ... (rest of your awk script here) ...
            $1 == out { in_output = 1 }
            in_output && $1 != out && /^[A-Za-z0-9-]+\(/ { in_output = 0 }
            in_output && $1 == "Modes:" { in_modes = 1; next }
            in_modes && $1 != "" && $1 !~ /^[0-9]/ { in_modes = 0 }
            in_modes && /^[[:space:]]+[0-9]/ {
                line = $0
                for (i = 1; i <= NF; i++) {
                    if ($(i) ~ /Hz$/) {
                        freq = $(i)
                        sub(/Hz$/, "", freq)
                        freq += 0
                    }
                }
                if (freq > max) {
                    max = freq
                    best = line
                }
            }
            END { if (best != "") print best }
        '
    }

    # List enabled outputs correctly
    OUTPUTS=$(${wlrRandr} | awk '
        /^[A-Za-z0-9-]+/ { name = $1 }
        /Enabled: yes/ { print name }
    ')

    for OUTPUT in $OUTPUTS; do
        MODE_LINE=$(get_max_refresh_mode "$OUTPUT")
        if [ -z "$MODE_LINE" ]; then
            echo "No modes found for $OUTPUT. Skipping."
            continue
        fi

        # The core logic to extract the mode string (e.g., 1920x1080@144Hz)
        MODE=$(echo "$MODE_LINE" | awk '{for(i=1;i<=NF;i++){if($i ~ /Hz$/){print $1 "@" $i; exit}}}')

        if [ -z "$MODE" ]; then
            echo "Could not parse mode for $OUTPUT. Skipping."
            continue
        fi

        echo "Setting $OUTPUT to max refresh: $MODE"
        ${wlrRandr} --output "$OUTPUT" --mode "$MODE"
    done
  '';
in {
  environment.packages = with pkgs; [
    dwl
    wlr-randr
  ];

  programs.dwl.extraSessionCommands = [
    # Execute the entire script using 'bash -c'
    "bash -c '${maxRefreshScript}'"

    # You might also want to run other commands here, like waybar, mako, etc.
    # "${pkgs.waybar}/bin/waybar &"
  ];

  systemd.user.targets.dwl-session.Unit = {
    Description = "dwl compositor session";
    Documentation = ["man:systemd.special(7)"];
    BindsTo = ["graphical-session.target"];
    Wants = ["graphical-session-pre.target"];
    After = ["graphical-session-pre.target"];
  };

  services.cliphist.enable = true;
}
