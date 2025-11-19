tmux-sessionizer() {
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$( (fd . ~/projects --exact-depth 1 -td; echo ~/.dotfiles ) | sed "s|^$HOME/||" | sk --margin 10% --color="bw")
fi

if [[ -z $selected ]]; then
    return 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]]; then
    if tmux has-session -t="$selected_name" 2>/dev/null; then
        tmux attach-session -t "$selected_name"
    else
        tmux new-session -s "$selected_name" -c "$selected"
    fi
else
    if tmux has-session -t="$selected_name" 2>/dev/null; then
        tmux switch-client -t "$selected_name"
    else
        tmux new-session -ds "$selected_name" -c "$selected"
        tmux switch-client -t "$selected_name"
    fi
fi
}
