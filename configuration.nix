{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root" "fqian"];
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    supportedFilesystems = ["ntfs"];
  };

  systemd.services.protonvpn-portforward = {
    description = "ProtonVPN NAT-PMP port forwarding";
    after = ["wg-quick-protonvpn.service"];
    wants = ["wg-quick-protonvpn.service"];
    path = [pkgs.libnatpmp];
    script = ''
      while true; do
        date
        natpmpc -a 1 0 udp 60 -g 10.2.0.1 && natpmpc -a 1 0 tcp 60 -g 10.2.0.1 || {
          echo "ERROR with natpmpc command"
          break
        }
        sleep 45
      done
    '';
    serviceConfig = {
      Type = "simple";
      Restart = "always";
    };
    wantedBy = ["multi-user.target"];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    evtest
    libnatpmp
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  networking = {
    hostName = "nixos";
    # wireless.enable = true;
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [22];
      checkReversePath = false;
    };
    wg-quick.interfaces.protonvpn = {
      autostart = true;
      configFile = "/etc/wireguard/wg-CH-850.conf";
    };
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    #   font = "Lat2-Terminus16";
    keyMap = "uk";
    #   useXkbConfig = true; # use xkb.options in tty.
  };

  services = {
    xserver.videoDrivers = ["nvidia"];
    displayManager.ly.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    # printing.enable = true; # Printing
    # libinput.enable = true; # Touchpad support
    openssh = {
      enable = true; # Enable the OpenSSH daemon.
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "prohibit-password";
      };
    };
  };

  users.users.fqian = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialPassword = "password";
  };

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.05"; # Don't touch
}
