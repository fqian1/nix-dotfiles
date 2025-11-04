{
  vpn = import ./vpn.nix;
  impermanence = import ./impermanence.nix;
  packages = import ./packages.nix;
  xdg = import ./xdg.nix;
  audio = import ./audio.nix;
}
