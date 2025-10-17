{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
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
    path = [pkgs.libnatpmp pkgs.gawk];
    script = ''
      while true; do
        date
        UDP_OUTPUT=$(natpmpc -a 1 0 udp 60 -g 10.2.0.1)
        UDP_EXIT=$?
        TCP_OUTPUT=$(natpmpc -a 1 0 tcp 60 -g 10.2.0.1)
        TCP_EXIT=$?

        if [ $UDP_EXIT -eq 0 ] && [ $TCP_EXIT -eq 0 ]; then
          # Extract port number from UDP output (assuming same port for TCP)
          PORT=$(echo "$UDP_OUTPUT" | grep -o 'Mapped public port [0-9]*' | gawk '{print $4}')
          if [ -n "$PORT" ]; then
            echo "$PORT" > /var/run/protonvpn-forwarded-port
            echo "Forwarded port: $PORT"
          else
            echo "ERROR: Could not extract port number"
          fi
        else
          echo "ERROR with natpmpc command"
          break
        fi
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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  networking = {
    hostName = "nixos";
    # wireless.enable = true;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
      checkReversePath = false;
      trustedInterfaces = ["wg0" "protonvpn"];
      extraCommands = ''
        iptables -A OUTPUT -d 89.222.96.30 -p udp --dport 51820 -j ACCEPT
        #ip6tables -A OUTPUT -d 89.222.96.30 -p udp --dport 51820 -j ACCEPT
      '';
      extraStopCommands = ''
        iptables -D OUTPUT -d 89.222.96.30 -p udp --dport 51820 -j ACCEPT
        #ip6tables -D OUTPUT -d 89.222.96.30 -p udp --dport 51820 -j ACCEPT
      '';
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

  programs.hyprland.enable = true;
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
