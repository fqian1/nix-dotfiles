{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard-rs
    qt5.qtwayland
    qt6.qtwayland
    swaylock
    dwl
    grim
    slurp
  ];

  systemd.user.targets.dwl-session.Unit = {
    Description = "dwl compositor session";
    Documentation = [ "man:systemd.special(7)" ];
    BindsTo = [ "graphical-session.target" ];
    Wants = [ "graphical-session-pre.target" ];
    After = [ "graphical-session-pre.target" ];
  };

  services.cliphist.enable = true;
}
