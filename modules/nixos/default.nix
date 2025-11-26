{
  impermanence = import ./impermanence.nix;
  bootloader = import ./bootloader.nix;
  networking = import ./networking.nix;
  nix-ld = import ./nix-ld.nix;
  greetd = import ./greetd.nix;
  locale = import ./locale.nix;
  audio = import ./audio.nix;
  vpn = import ./vpn.nix;
  ssh = import ./ssh.nix;
  mangowc = import ./mangowc.nix;
}
