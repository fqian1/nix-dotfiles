{ ... }:
{
  bash = import ./bash.nix;
  direnv = import ./direnv.nix;
  packages = import ./packages.nix;
  starship = import ./starship.nix;
  tmux = import ./tmux.nix;
  yazi = import ./yazi.nix;
  lazygit = import ./lazygit.nix;
}
