{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    outputs.nixosModules.audio
    outputs.nixosModules.greetd
    outputs.nixosModules.networking
    outputs.nixosModules.impermanence
    outputs.nixosModules.nix-ld
    outputs.nixosModules.security
    # outputs.nixosModules.bootloader
    outputs.nixosModules.locale
    # outputs.nixosModules.vpn
    outputs.nixosModules.mangowc
    ./hardware.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # config.allowUnfree = true;
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "fqian"
      ];
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
    channel.enable = false;
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
  };

  users.users.fqian = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    initialPassword = "password";
    shell = pkgs.bash;
  };

  networking = {
    hostName = "laptop";
    hostId = "8425e349";
    useDHCP = lib.mkForce true;
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    unzip
    p7zip
    nmap
    git
    tree
    evtest
  ];

  services = {
    printing.enable = true;
    libinput.enable = true;
    fwupd.enable = true;
  };

  system.stateVersion = "25.05";
}
