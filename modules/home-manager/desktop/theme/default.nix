{
  config,
  lib,
  pkgs,
  ...
}:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      roboto
      noto-fonts
    ];
    enableDefaultPackages = true;
    fontDir = {
      enable = true;
    };
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Fira Code Nerd Font" ];
        sansSerif = [
          "Roboto"
          "Noto Sans"
        ];
        serif = [ "Noto Serif" ];
      };
    };
  };

  programs.dconf.enable = true;

  home-manager.users.fqian =
    { pkgs, ... }:
    {
      home.pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
      gtk = {
        enable = true;
        cursorTheme = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
        };
        gtk2.extraConfig = "gtk-application-prefer-dark-theme = true;";
        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = true;
          "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
        };
        gtk4.extraConfig = {
          Settings = ''
            gtk-cursor-theme-name=Bibata-Modern-Classic
          '';
        };

        font = {
          name = "Fira Code";
          size = 10;
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "breeze";
        style.name = "breeze";
      };
    };
}
