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
    # outputs.nixosModules.vpn
    outputs.nixosModules.audio
    outputs.nixosModules.locale
    outputs.nixosModules.dwl
    outputs.nixosModules.greetd
    outputs.nixosModules.networking
    outputs.nixosModules.impermanence
    outputs.nixosModules.silent-boot
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

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_GB.UTF-8";
      LANGUAGE = "en_US.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };

  time.timeZone = "Europe/London";

  users.users.fqian = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYmIuYxMUnrHQWW5LcUGqKsNfonYf/7Vjqz+kNKPMo2 fqian@nixos"
    ];
    initialPassword = "password";
    shell = pkgs.bash;
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

  networking = {
    hostName = "nixos-laptop";
    hostId = "8425e349";
    useDHCP = lib.mkForce true;
  };

  services = {
    printing.enable = true;
    libinput.enable = true;
    fwupd.enable = true;
  };

  system.stateVersion = "25.05";
}
