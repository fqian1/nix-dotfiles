{
  impermanence = import ./impermanence.nix;
  silent-boot = import ./silent-boot.nix;
  networking = import ./networking.nix;
  nix-ld = import ./nix-ld.nix;
  greetd = import ./greetd.nix;
  audio = import ./audio.nix;
  vpn = import ./vpn.nix;
  dwl = import ./dwl.nix;
}
