{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
      configPackages = with pkgs; [ xdg-desktop-portal-hyprland ];
    };
  };
  programs.dconf.enable = true;
}
