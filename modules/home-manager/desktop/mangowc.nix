{...}: {
  xdg.configFile."mango/config.conf".text = ''
    # Window effect
    blur=0
    shadows = 0
    border_radius=0
    focused_opacity=1.0
    unfocused_opacity=1.0
    animations=0

    # Scroller Layout Setting
    scroller_structs=20
    scroller_default_proportion=0.8
    scroller_focus_center=0
    scroller_prefer_center=0
    edge_scroller_pointer_focus=1
    scroller_default_proportion_single=1.0
    scroller_proportion_preset=0.5,0.8,1.0

    # Master-Stack Layout Setting
    new_is_master=1
    default_mfact=0.55
    default_nmaster=1
    smartgaps=0

    # Overview Setting
    hotarea_size=10
    enable_hotarea=1
    ov_tab_mode=0
    overviewgappi=5
    overviewgappo=30

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
    # need relogin to make it apply
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
    rootcolor=0x201b14ff
    focuscolor=0xc9b890ff
    maximizescreencolor=0x89aa61ff
    urgentcolor=0xad401fff
    scratchpadcolor=0x516c93ff
    globalcolor=0xb153a7ff
    overlaycolor=0x14a57cff

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

    # Key Bindings
    # key name refer to `xev` or `wev` command output,
    # mod keys name: super,ctrl,alt,shift,none

    # reload config
    bind=SUPER,r,reload_config
    bind=ALT,space,spawn,rofi -show drun
    bind=ALT,Return,spawn,foot
    bind=ALT,m,quit
    bind=ALT+SHIFT,q,killclient,

    # switch window focus
    bind=SUPER,Tab,focusstack,next
    bind=ALT,l,focusdir,left
    bind=ALT,h,focusdir,right
    bind=ALT,k,focusdir,up
    bind=ALT,j,focusdir,down

    # swap window
    bind=SUPER+SHIFT,Up,exchange_client,up
    bind=SUPER+SHIFT,Down,exchange_client,down
    bind=SUPER+SHIFT,Left,exchange_client,left
    bind=SUPER+SHIFT,Right,exchange_client,right

    # switch window status
    bind=SUPER,g,toggleglobal,
    bind=ALT,Tab,toggleoverview,
    bind=ALT,backslash,togglefloating,
    bind=ALT,a,togglemaximizescreen,
    bind=ALT,f,togglefullscreen,
    bind=ALT+SHIFT,f,togglefakefullscreen,
    bind=SUPER,i,minimized,
    bind=SUPER,o,toggleoverlay,
    bind=SUPER+SHIFT,I,restore_minimized
    bind=ALT,z,toggle_scratchpad

    # scroller layout
    bind=ALT,e,set_proportion,1.0
    bind=ALT,x,switch_proportion_preset,

    # switch layout
    bind=SUPER,n,switch_layout

    # tag switch
    bind=SUPER,Left,viewtoleft,0
    bind=CTRL,Left,viewtoleft_have_client,0
    bind=SUPER,Right,viewtoright,0
    bind=CTRL,Right,viewtoright_have_client,0
    bind=CTRL+SUPER,Left,tagtoleft,0
    bind=CTRL+SUPER,Right,tagtoright,0

    bind=Alt,1,view,1,0
    bind=Alt,2,view,2,0
    bind=Alt,3,view,3,0
    bind=Alt,4,view,4,0
    bind=Alt,5,view,5,0
    bind=Alt,6,view,6,0
    bind=Alt,7,view,7,0
    bind=Alt,8,view,8,0
    bind=Alt,9,view,9,0

    # tag: move client to the tag and focus it
    # tagsilent: move client to the tag and not focus it
    # bind=Alt,1,tagsilent,1
    bind=Alt,1,tag,1,0
    bind=Alt,2,tag,2,0
    bind=Alt,3,tag,3,0
    bind=Alt,4,tag,4,0
    bind=Alt,5,tag,5,0
    bind=Alt,6,tag,6,0
    bind=Alt,7,tag,7,0
    bind=Alt,8,tag,8,0
    bind=Alt,9,tag,9,0

    # monitor switch
    bind=alt+shift,Left,focusmon,left
    bind=alt+shift,Right,focusmon,right
    bind=SUPER+Alt,Left,tagmon,left
    bind=SUPER+Alt,Right,tagmon,right

    # movewin
    bind=CTRL+SHIFT,Up,movewin,+0,-50
    bind=CTRL+SHIFT,Down,movewin,+0,+50
    bind=CTRL+SHIFT,Left,movewin,-50,+0
    bind=CTRL+SHIFT,Right,movewin,+50,+0

    # resizewin
    bind=CTRL+ALT,Up,resizewin,+0,-50
    bind=CTRL+ALT,Down,resizewin,+0,+50
    bind=CTRL+ALT,Left,resizewin,-50,+0
    bind=CTRL+ALT,Right,resizewin,+50,+0

    # Mouse Button Bindings
    # NONE mode key only work in ov mode
    mousebind=SUPER,btn_left,moveresize,curmove
    mousebind=SUPER,btn_right,moveresize,curresize
    mousebind=NONE,btn_left,toggleoverview,1
    mousebind=NONE,btn_right,killclient,0

    # Axis Bindings
    axisbind=SUPER,UP,viewtoleft_have_client
    axisbind=SUPER,DOWN,viewtoright_have_client

    # layer rule
    layerrule=animation_type_open:zoom,layer_name:rofi
    layerrule=animation_type_close:zoom,layer_name:rofi

    env=GTK_IM_MODULE,fcitx
    env=QT_IM_MODULE,fcitx
    env=SDL_IM_MODULE,fcitx
    env=XMODIFIERS,@im=fcitx
    env=GLFW_IM_MODULE,ibus

    env=QT_QPA_PLATFORMTHEME,qt5ct
    env=QT_AUTO_SCREEN_SCALE_FACTOR,1
    env=QT_QPA_PLATFORM,Wayland;xcb
    env=QT_WAYLAND_FORCE_DPI,140

    exec ~/.config/mango/autostart.sh
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
