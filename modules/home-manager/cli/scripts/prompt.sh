ble-import contrib/prompt-git

function ble/prompt/backslash:cwd2 {
  local dir="${PWD##*/}"
  local pdir_full="${PWD%/*}"
  local pdir="${pdir_full##*/}" # Extract basename by default

  if [[ "$PWD" == "$HOME" ]]; then
    ble/prompt/print "~"
  elif [[ "$PWD" == "/" ]]; then
    ble/prompt/print "/"
  elif [[ -z "$pdir_full" ]]; then # Checks if PWD is / (which is already covered, but good for completeness)
    ble/prompt/print "$dir"
  elif [[ "$pdir_full" == "$HOME" ]]; then
    ble/prompt/print "~/$dir" # Check if the full parent path is HOME
  else
    ble/prompt/print "$pdir/$dir"
  fi
}

PS1="[\u@\h][\q{cwd2}][\q{contrib/git-branch}]\$ "

bleopt prompt_rps1='[\t]'
