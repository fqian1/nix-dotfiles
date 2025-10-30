{ config, pkgs, ... }:
{
  programs.hyprland.enable = true;
  services = {
    xserver.videoDrivers = [ "nvidia" ];
    displayManager.ly.enable = true;
    # printing.enable = true; # Printing
    # libinput.enable = true; # Touchpad support
  };

  home-manager.users.fqian =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [
        wl-clipboard-rs
        qt5.qtwayland
        qt6.qtwayland
      ];
      programs.hyprshot.enable = true;
      services.cliphist.enable = true;
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true;

        settings = {
          env = [
            "HYPRCURSOR_THEME,${config.home.pointerCursor.name}"
            "HYPRCURSOR_SIZE,${toString config.home.pointerCursor.size}"
          ];
          exec-once = [
            "nm-applet --indicator"
            "[workspace 1 silent] firefox"
            "[workspace 2 silent] kitty"
            "[workspace 3 silent] firefox"
            "[workspace 4 silent] obsidian"
            "[workspace 5 silent] qbittorrent"
          ];

          monitor = [
            ",highrr,0x0,1"
            ",highrr,auto-right,1"
          ];

          input = {
            kb_layout = "gb";
            kb_variant = "";
            kb_model = "";
            accel_profile = "flat";
            follow_mouse = 2;
            touchpad = {
              natural_scroll = "no";
              disable_while_typing = true;
              "tap-to-click" = false;
              scroll_factor = 0.7;
            };
            sensitivity = -0.5;
          };

          general = {
            gaps_in = 0;
            gaps_out = 0;
            border_size = 3;
            "col.active_border" = "rgba(595959ff)";
            "col.inactive_border" = "rgba(000000ff)";
            no_border_on_floating = true;
            layout = "master";
            allow_tearing = false;
          };

          decoration = {
            rounding = 0;
            active_opacity = 1;
            inactive_opacity = 1;
            fullscreen_opacity = 1;
            blur = {
              enabled = false;
            };
          };

          animations = {
            enabled = false;
          };

          master = {
            allow_small_split = true;
            mfact = 0.70;
            inherit_fullscreen = false;
          };

          misc = {
            force_default_wallpaper = 1;
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            vfr = true;
          };

          windowrulev2 = [ "suppressevent maximize, class:.*" ];

          "$mainMod" = "Alt_L";
          "$terminal" = "kitty";
          "$fileManager" = "dolphin";
          "$browser" = "firefox";
          "$menu" = "wofi --show drun";

          bind = [
            "$mainMod, RETURN, exec, $terminal"
            "$mainMod, Q, killactive,"
            "$mainMod SHIFT, Q, exit,"
            "$mainMod, Space, exec, $menu"
            "$mainMod, E, exec, $browser"
            "$mainMod, F, fullscreen"
            "$mainMod CTRL, L, exec, hyprlock"
            "$mainMod, h, movefocus, l"
            "$mainMod, j, movefocus, d"
            "$mainMod, k, movefocus, u"
            "$mainMod, l, movefocus, r"
            "$mainMod SUPER, h, movewindow, l"
            "$mainMod SUPER, j, movewindow, d"
            "$mainMod SUPER, k, movewindow, u"
            "$mainMod SUPER, l, movewindow, r"
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"
          ];

          binde = [
            "$mainMod SHIFT, h, resizeactive, -20 0"
            "$mainMod SHIFT, j, resizeactive, 0 20"
            "$mainMod SHIFT, k, resizeactive, 0 -20"
            "$mainMod SHIFT, l, resizeactive, 20 0"
          ];
        };
        extraConfig = ''
          ecosystem:no_update_news = true
          workspace = 1, monitor:HDMI-A-1, default:true
          workspace = 2, monitor:DP-1, default:true
          workspace = 3, monitor:DP-1
          workspace = 4, monitor:DP-1
          workspace = 5, monitor:DP-1
          workspace = 6, monitor:DP-1
        '';
      };
    };
}
