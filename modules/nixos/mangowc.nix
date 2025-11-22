{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    mangowc
    wlr-randr
    wlroots
    wayland
    wayland-protocols
  ];

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   config = with pkgs; [
  #     xdg-desktop-portal-wlr
  #   ];
  # };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };

  # extraSessionCommands = ''
  #   # SDL:
  #   export SDL_VIDEODRIVER=wayland
  #   # QT (needs qt5.qtwayland in systemPackages):
  #   export QT_QPA_PLATFORM=wayland-egl
  #   export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
  #   # Fix for some Java AWT applications (e.g. Android Studio),
  #   # use this if they aren't displayed properly:
  #   export _JAVA_AWT_WM_NONREPARENTING=1
  # '';
}
