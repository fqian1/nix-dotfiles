function ble/prompt/backslash:cwd2 {
  local dir="${PWD##*/}"
  local pdir="${PWD%/*}"
  pdir="${pdir##*/}"

  if [[ "$PWD" == "$HOME" ]]; then
    ble/prompt/print "~"
  elif [[ "$PWD" == "/" ]]; then
    ble/prompt/print "/"
  elif [[ -z "$pdir" ]]; then
    ble/prompt/print "$dir"
  else
    ble/prompt/print "$pdir/$dir"
  fi
}

PS1='[\g{bold,fg=green}\u\g{none}@\g{bold,fg=navy}\h\g{none}][\q{cwd2}][\q{git_status}] \g{fg=red}\$\g{none} > '


bleopt prompt_rps1='\q{contrib/git-info}'
# bleopt prompt_rps1='\q{contrib/git-path}'
# bleopt prompt_rps1='\q{contrib/git-name}'
# bleopt prompt_rps1='\q{contrib/git-hash}'
# bleopt prompt_rps1='\q{contrib/git-branch}'
# bleopt prompt_rps1='\g{bold,fg=yellow}\t\g{none}'
