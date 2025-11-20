{
  impermanence = import ./impermanence.nix;
  silent-boot = import ./silent-boot.nix;
  networking = import ./networking.nix;
  scripts = import ./scripts.nix;
  nix-ld = import ./nix-ld.nix;
  greetd = import ./greetd.nix;
  locale = import ./locale.nix;
  audio = import ./audio.nix;
  vpn = import ./vpn.nix;
  ssh = import ./ssh.nix;
  mangowc = import ./mangowc.nix;
}
