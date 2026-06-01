tmux-sessionizer() {
    selected_name=$(basename "$selected" | tr . _)

    if [ -z "$TMUX" ]; then
        if tmux has-session -t "$selected_name" 2>/dev/null; then
            exec tmux attach-session -t "$selected_name"
        else
            exec tmux new-session -s "$selected_name" -c "$selected"
        fi
    else
        if tmux has-session -t "$selected_name" 2>/dev/null; then
            tmux switch-client -t "$selected_name"
        else
            tmux new-session -d -s "$selected_name" -c "$selected"
            tmux switch-client -t "$selected_name"
        fi
    fi
}
