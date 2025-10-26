{ lib, ... }:
{
  imports = [
    ./hardware.nix
  ];

  networking = {
    hostName = "nixos";
    hostId = "b475238a";
    # wireless.enable = true;
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    useDHCP = lib.mkForce true;
  };

  system.stateVersion = "25.05";
}
