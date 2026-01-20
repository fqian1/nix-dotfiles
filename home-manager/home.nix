{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    outputs.homeManagerModules.cli.tools
    outputs.homeManagerModules.cli.bash
    outputs.homeManagerModules.cli.tmux
    outputs.homeManagerModules.cli.scripts
    outputs.homeManagerModules.cli.colorschemes

    outputs.homeManagerModules.desktop.mangowc
    outputs.homeManagerModules.desktop.theme
    outputs.homeManagerModules.desktop.applications.librewolf
    outputs.homeManagerModules.desktop.applications.discord
    outputs.homeManagerModules.desktop.applications.foot
    outputs.homeManagerModules.desktop.applications.obsidian
    outputs.homeManagerModules.desktop.applications.qbittorrent
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  home = {
    stateVersion = "25.05";
    username = "fqian";
    homeDirectory = "/home/fqian";
    sessionVariables = {
      EDITOR = "nvim";
      XKB_DEFAULT_LAYOUT = "gb";
      XKB_DEFAULT_OPTION = "cap:swapescape,ctrl:alt_r";
      # SOPS_AGE_KEY_FILE = "/.config/sops/age/keys.txt";
    };
    keyboard = {
      layout = "gb";
      options = [
        "ctrl:alt_r"
        "caps:swapescape"
      ];
    };
    packages = with pkgs; [
      neovim-custom
      xdg-user-dirs
      xdg-utils

      wl-clipboard-rs
      qt5.qtwayland
      qt6.qtwayland
      swaylock
      swaybg
      grim
      slurp

      foot
      wmenu
    ];
  };

  programs = {
    home-manager.enable = true;
    ssh = {
      enable = true;
    };

    git = {
      enable = true;
      settings = {
        user = {
          Name = "fqian";
          Email = "francois.qian2@gmail.com";
        };
      };
    };
  };

  systemd.user.startServices = "sd-switch";
  services.ssh-agent = {
    enable = true;
    enableBashIntegration = true;
  };

  services = {
    cliphist.enable = true;
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      desktop = "$HOME/desktop";
      documents = "$HOME/documents";
      download = "$HOME/downloads";
      music = "$HOME/music";
      pictures = "$HOME/pictures";
      publicShare = "$HOME/desktop";
      templates = "$HOME/templates";
      videos = "$HOME/videos";
      createDirectories = true;
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = ["librewolf.desktop"];
        "x-scheme-handler/https" = ["librewolf.desktop"];
        "x-scheme-handler/chrome" = ["librewolf.desktop"];
        "text/html" = ["librewolf.desktop"];
        "application/x-extension-htm" = ["librewolf.desktop"];
        "application/x-extension-html" = ["librewolf.desktop"];
        "application/x-extension-shtml" = ["librewolf.desktop"];
        "application/xhtml+xml" = ["librewolf.desktop"];
        "application/x-extension-xhtml" = ["librewolf.desktop"];
        "application/x-extension-xht" = ["librewolf.desktop"];
      };
    };
  };
}
