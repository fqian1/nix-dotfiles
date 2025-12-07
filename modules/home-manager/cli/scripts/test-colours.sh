test-colours() {
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/";
        s=s s s s s s s s s s s s s s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
}

print-colours() {
    RESET='\033[0m'

    echo "Base 16 Terminal Colors (0-15):"
    echo "------------------------------"

    # Print the 8 regular colors (0-7) and their bright equivalents (8-15)

    # Use printf for reliable escape sequence interpretation
    # \033[48;5;${i}m sets the background color (48;5; for 256-color)
    # \033[38;5;${i}m sets the foreground color (38;5; for 256-color)
    # \033[0m resets the color

    # Display colors 0 through 7
    for i in {0..7}; do
        printf "%b  BG %02d  FG %02d  %b" \
            "$(printf '\033[48;5;%dm\033[38;5;%dm' "$i" "$i")" \
            "$i" "$i" \
            "${RESET}"
    done
    echo "" # Newline after the first block

    # Display colors 8 through 15
    for i in {8..15}; do
        printf "%b  BG %02d  FG %02d  %b" \
            "$(printf '\033[48;5;%dm\033[38;5;%dm' "$i" "$i")" \
            "$i" "$i" \
            "${RESET}"
    done
    echo "" # Final newline
}
