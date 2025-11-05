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
    outputs.homeManagerModules.cli.packages
    outputs.homeManagerModules.cli.bash
    outputs.homeManagerModules.cli.direnv
    outputs.homeManagerModules.cli.lazygit
    outputs.homeManagerModules.cli.starship
    outputs.homeManagerModules.cli.tmux
    outputs.homeManagerModules.cli.yazi

    outputs.homeManagerModules.desktop.hyprland
    outputs.homeManagerModules.desktop.theme

    outputs.homeManagerModules.desktop.applications.firefox
    outputs.homeManagerModules.desktop.applications.discord
    outputs.homeManagerModules.desktop.applications.kitty
    outputs.homeManagerModules.desktop.applications.obsidian
    outputs.homeManagerModules.desktop.applications.qbittorrent
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modification
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.fqian = {
      home = {
        stateVersion = "25.05";
        username = "fqian";
        homeDirectory = "/home/fqian";
        sessionVariables = {
          EDITOR = "nvim";
          # SOPS_AGE_KEY_FILE = "/.config/sops/age/keys.txt";
        };
      };

      systemd.user.startServices = "sd-switch";

      programs = {
        home-manager.enable = true;
        ssh = {
          enable = true;
          startAgent = true;
          matchBlocks = {
            "github" = {
              hostname = "github.com";
              user = "git";
            };

            "nixos" = {
              hostname = "nixos";
              user = "fqian";
              port = 2222;
              identityFile = "~/.ssh/id_nixos";
              extraOptions = {
                ForwardAgent = "yes";
              };
              "*" = {
                extraOptions = {
                  ServerAliveInterval = "60";
                };
              };
            };
          };

          knownHosts = {
            "github.com" = {
              publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF2TpTZhKVF3HvwepYu0LbeavbGjG8iF3cANfg2BLJ9o francois.qian2@gmail.com";
            };
            "nixos" = {
              publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYmIuYxMUnrHQWW5LcUGqKsNfonYf/7Vjqz+kNKPMo2 fqian@nixos";
            };
          };
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

      packages = with pkgs; [
        nvim
        xdg-user-dirs
        xdg-utils
      ];

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
      };
    };
  };
}
