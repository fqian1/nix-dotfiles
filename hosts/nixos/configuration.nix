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
    outputs.nixosModules.vpn
    outputs.nixosModules.impermanence
    ./hardware.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
        trusted-users = [
          "root"
          "fqian"
        ];
      };
      channel.enable = false;

      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  console = {
    font = "Lat2-Terminus16";
    # keyMap = "uk";
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
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

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

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
      KbdInteractiveAuthentication = false;
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

  services = {
    xserver.videoDrivers = [ "nvidia" ];
    displayManager.ly.enable = true;
    # printing.enable = true; # Printing
    # libinput.enable = true; # Touchpad support
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  programs.dconf.enable = true;

  services.fwupd.enable = true;

  programs.nix-ld.enable = true; # Just in case

  system.stateVersion = "25.05";
}
