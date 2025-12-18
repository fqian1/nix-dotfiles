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

    for i in {0..15}; do
        # \033[48;5;%dm sets only the background
        printf "\033[48;5;%dm  Color %02d  %b " "$i" "$i" "$RESET"

        # Add a line break after the 8th color (ID 7)
        if [ $i -eq 7 ]; then echo ""; fi
    done
    echo ""
}
