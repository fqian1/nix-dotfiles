{...}: {
  xdg.configFile."mango/config.conf".text = ''
    # Window effect
    blur=0
    shadows = 0
    border_radius=0
    focused_opacity=1.0
    unfocused_opacity=1.0
    animations=0

    # Misc
    axis_bind_apply_timeout=100
    focus_on_activate=1
    inhibit_regardless_of_visibility=0
    sloppyfocus=1
    warpcursor=1
    focus_cross_monitor=0
    focus_cross_tag=0
    enable_floating_snap=0
    snap_distance=30
    cursor_size=24
    drag_tile_to_tile=1

    # keyboard
    repeat_rate=40
    repeat_delay=300
    numlockon=0
    xkb_rules_layout=gb
    xkb_rules_options=caps:swapescape,ctrl:ralt_rctrl

    # Trackpad
    disable_trackpad=0
    tap_to_click=1
    tap_and_drag=1
    drag_lock=1
    trackpad_natural_scrolling=0
    disable_while_typing=1
    left_handed=0
    middle_button_emulation=0
    swipe_min_threshold=1

    # mouse
    mouse_natural_scrolling=0
    accel_profile=0
    accel_speed=-0.6

    # Appearance
    gappih=0
    gappiv=0
    gappoh=0
    gappov=0
    scratchpad_width_ratio=0.8
    scratchpad_height_ratio=0.9
    borderpx=0

    # layout support:
    # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
    tagrule=id:1,layout_name:tile
    tagrule=id:2,layout_name:tile
    tagrule=id:3,layout_name:tile
    tagrule=id:4,layout_name:tile
    tagrule=id:5,layout_name:tile
    tagrule=id:6,layout_name:tile
    tagrule=id:7,layout_name:tile
    tagrule=id:8,layout_name:tile
    tagrule=id:9,layout_name:tile

    bind=SUPER,r,reload_config
    bind=ALT,space,spawn,wmenu
    bind=ALT,e,spawn,librewolf
    bind=ALT,Return,spawn,foot
    bind=ALT,q,killclient,
    bind=SUPER,Tab,focusstack,next
    bind=ALT,l,focusdir,right
    bind=ALT,h,focusdir,left
    bind=ALT,k,focusdir,up
    bind=ALT,j,focusdir,down
    bind=ALT+SHIFT,Up,exchange_client,up
    bind=ALT+SHIFT,Down,exchange_client,down
    bind=ALT+SHIFT,Left,exchange_client,left
    bind=ALT+SHIFT,Right,exchange_client,right

    # switch window status
    bind=ALT,Tab,toggleoverview,
    bind=ALT,backslash,togglefloating,
    bind=ALT,z,toggle_scratchpad

    # switch layout
    bind=SUPER,n,switch_layout

    bind=ALT,1,comboview,1,1
    bind=ALT,2,comboview,2,2
    bind=ALT,3,comboview,3,3
    bind=ALT,4,comboview,4,4
    bind=ALT,5,comboview,5,5
    bind=ALT,6,comboview,6,6
    bind=ALT,7,comboview,7,7
    bind=ALT,8,comboview,8,8
    bind=ALT,9,comboview,9,9

    # tag: move client to the tag and focus it
    bind=ALT+SHIFT,1,tagsilent,1,0
    bind=ALT+SHIFT,2,tagsilent,2,0
    bind=ALT+SHIFT,3,tagsilent,3,0
    bind=ALT+SHIFT,4,tagsilent,4,0
    bind=ALT+SHIFT,5,tagsilent,5,0
    bind=ALT+SHIFT,6,tagsilent,6,0
    bind=ALT+SHIFT,7,tagsilent,7,0
    bind=ALT+SHIFT,8,tagsilent,8,0
    bind=ALT+SHIFT,9,tagsilent,9,0

    # monitor switch
    bind=ALT,[,focusmon,left
    bind=ALT,],focusmon,right

    # Mouse Button Bindings
    # NONE mode key only work in ov mode
    mousebind=ALT,btn_left,moveresize,curmove
    mousebind=ALT,btn_right,moveresize,curresize
    mousebind=NONE,btn_left,toggleoverview,1
    mousebind=NONE,btn_right,killclient,0

    # layer rule
    layerrule=animation_type_open:zoom,layer_name:wmenu
    layerrule=animation_type_close:zoom,layer_name:wmenu

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

      # /usr/lib/xfce-polkit/xfce-polkit &
    '';
  };
}
