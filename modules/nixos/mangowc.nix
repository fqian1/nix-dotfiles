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

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };

  xdg.configFile."mango/config.conf".text = ''
    bind=SUPER,Return,spawn,foot
    bind=SUPER,d,spawn,bemenu-run
    bind=SUPER,q,kill
    bind=SUPER,M,exit

    cursor_size=24
    env=XCURSOR_SIZE,24

    env=GTK_IM_MODULE,fcitx
    env=QT_IM_MODULE,fcitx
    env=SDL_IM_MODULE,fcitx
    env=XMODIFIERS,@im=fcitx
    env=GLFW_IM_MODULE,ibus

    env=QT_QPA_PLATFORMTHEME,qt5ct
    env=QT_AUTO_SCREEN_SCALE_FACTOR,1
    env=QT_QPA_PLATFORM,Wayland;xcb
    env=QT_WAYLAND_FORCE_DPI,140
  '';

  xdg.configFile."mango/autostart.sh" = {
    executable = true;
    text = ''
      #! /bin/bash
      set +e

      max-refresh
      swaybg -i ~/pictures/moon.png &

      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

      # swaync &

      wl-clip-persist --clipboard regular --reconnect-tries 0 &
      wl-paste --type text --watch cliphist store &

      echo "Xft.dpi: 140" | xrdb -merge
      gsettings set org.gnome.desktop.interface text-scaling-factor 1.4

      # /usr/lib/xfce-polkit/xfce-polkit &
    '';
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
