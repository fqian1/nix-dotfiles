{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # outputs.nixosModules.vpn
    outputs.nixosModules.impermanence
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
    nixPath = ["nixpkgs=flake:nixpkgs"];
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

    wlroots
    wayland
    wayland-protocols
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  networking = {
    hostName = "nixos-laptop";
    hostId = "8425e349";
    wireless = {
      enable = true;
      networks = {
        "VM3764440" = {
          psk = "wtw3mzywDbNw";
        };
        "iPhone 13 Pro" = {
          psk = "reps4jesus";
        };
        "ASK4 Wireless (802.1x)" = {
          psk = "amount-strong-got-electric";
        };
        "ASK4 Wireless" = {
          psk = "amount-strong-got-electric";
        };
      };
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    useDHCP = lib.mkForce true;
    firewall.allowedTCPPorts = [22];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
      KbdInteractiveAuthentication = false;
    };
  };

  services = {
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.dwl}/bin/dwl";
          user = "fqian";
        };
        default_session = initial_session;
      };
    };
    # printing.enable = true; # Printing
    libinput.enable = true; # Touchpad support
    libinput.touchpad.accelProfile = "custom";
    libinput.touchpad.accelStepScroll = 0.5;
    libinput.touchpad.accelPointsScroll = [
      0.0 # Input Speed 0.0 -> Output Speed 0.0
      0.25 # Input Speed 0.5 -> Output Speed 0.25 (Slower)
      0.5 # Input Speed 1.0 -> Output Speed 0.5 (Slower)
      0.75 # Input Speed 1.5 -> Output Speed 0.75 (Slower)
      1.0 # Input Speed 2.0 -> Output Speed 1.0 (Slower)
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  programs.dconf.enable = true;
  programs.dwl.enable = true;

  services.fwupd.enable = true;

  programs.nix-ld.enable = true; # Just in case

  system.stateVersion = "25.05";
}
