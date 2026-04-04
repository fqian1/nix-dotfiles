{
  bash = import ./bash.nix;
  tools = import ./tools.nix;
  scripts = import ./scripts.nix;
  vim = import ./vim.nix;
  tmux = import ./tmux.nix;
  colorschemes = import ./colorschemes.nix;
  ssh = import ./ssh.nix;
}
