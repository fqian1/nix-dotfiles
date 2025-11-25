find-edit() {
    local file_to_edit
    file_to_edit=$(fd $@ . ~/.dotfiles -tf | fzy)

    if [[ -n "$file_to_edit" ]]; then
        vim "$file_to_edit"
    fi
}
