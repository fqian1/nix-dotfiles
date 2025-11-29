function handle_nvim_suspend() {
    if jobs -s | grep -q "nvim"; then
        if [ "$NVIM_SUSPENDED" != "true" ]; then
            tput cuu 4
            tput el
            printf '\n'
            printf '\r'
            tput el
            printf '\n'
            printf '\r'
            tput el
            printf '\n'
            printf '\r'
            tput el
            printf '\n'
            printf '\r'
            tput cuu 4
            export NVIM_SUSPENDED="true"
        fi
    fi
}

alias fg='unset NVIM_SUSPENDED; command fg'

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }handle_nvim_suspend"
