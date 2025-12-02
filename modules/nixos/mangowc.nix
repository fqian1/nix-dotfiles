{
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    mangowc
    wlr-randr
    wlroots
    wayland
    wayland-protocols
  ];

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };
}
