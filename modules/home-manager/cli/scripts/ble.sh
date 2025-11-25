# https://github.com/akinomyoga/ble.sh/blob/master/blerc.template

ble-import contrib/prompt-git
ble-import contrib/integration/nix-completion

bleopt prompt_eol_mark=
bleopt exec_errexit_mark=
bleopt exec_elapsed_enabled='sys+usr>=5*60*1000'

bleopt complete_limit=100
bleopt complete_limit_auto=
bleopt complete_timeout_auto=5000

# ble-bind -m vi_imap -f 'C-m' accept-line
# ble-bind -m vi_nmap -f 'RET' accept-line
# ble-bind -m vi_imap -f 'RET' accept-line
# ble-bind -m vi_nmap -f 'C-m' accept-line

ble-bind -m vi_nmap --cursor 2
ble-bind -m vi_imap --cursor 5
ble-bind -m vi_omap --cursor 4
ble-bind -m vi_xmap --cursor 2
ble-bind -m vi_cmap --cursor 0

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

PS1='[\u@\h][\q{cwd2}]\q{git_branch_conditional}\$ '

bleopt prompt_rps1='[\t]'
