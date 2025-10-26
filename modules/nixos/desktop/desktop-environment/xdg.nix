{
  pkgs,
  ...
}:
{

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
      configPackages = with pkgs; [ xdg-desktop-portal-hyprland ];
    };
  };

  home-manager.users.fqian =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
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
        };
      };
    };
}
