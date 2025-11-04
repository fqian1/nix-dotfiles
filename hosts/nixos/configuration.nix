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
    outputs.nixosModules.xdg
    ./hardware.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modification
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
    };
  };

  services.fwupd.enable = true;

  programs.nix-ld.enable = true; # Just in case

  system.stateVersion = "25.05";
}
