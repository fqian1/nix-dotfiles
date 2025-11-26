{
  bash = import ./bash.nix;
  tools = import ./tools.nix;
  starship = import ./starship.nix;
  scripts = import ./scripts.nix;
  tmux = import ./tmux.nix;
  ssh = import ./ssh.nix;
}
