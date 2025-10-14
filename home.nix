{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  neovim-custom = import ./nvim/neovim.nix {
    inherit (pkgs) symlinkJoin neovim-unwrapped makeWrapper runCommandLocal vimPlugins lib;
  };
in {
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
  home.username = "fqian";
  home.homeDirectory = "/home/fqian";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    firefox
    tree
    vim
    ripgrep
    neovim-custom
    rust-analyzer
    lua-language-server
    clang-tools
    jdt-language-server
    pyright
    nil
    wget
    waybar
    hyprpaper
    alejandra
    nerd-fonts.fira-code
  ];

  programs.swaylock = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = lib.literalExpression ''
      format = """
      [](color_orange)\
      $os\
      $username\
      [](bg:color_yellow fg:color_orange)\
      $directory\
      [](fg:color_yellow bg:color_aqua)\
      $git_branch\
      $git_status\
      [](fg:color_aqua bg:color_blue)\
      $c\
      $cpp\
      $rust\
      $golang\
      $nodejs\
      $php\
      $java\
      $kotlin\
      $haskell\
      $python\
      [](fg:color_blue bg:color_bg3)\
      $docker_context\
      $conda\
      $pixi\
      [](fg:color_bg3 bg:color_bg1)\
      $time\
      [ ](fg:color_bg1)\
      $line_break$character"""

      palette = 'gruvbox_dark'

      [palettes.gruvbox_dark]
      color_fg0 = '#fbf1c7'
      color_bg1 = '#3c3836'
      color_bg3 = '#665c54'
      color_blue = '#458588'
      color_aqua = '#689d6a'
      color_green = '#98971a'
      color_orange = '#d65d0e'
      color_purple = '#b16286'
      color_red = '#cc241d'
      color_yellow = '#d79921'

      [os]
      disabled = false
      style = "bg:color_orange fg:color_fg0"

      [os.symbols]
      Windows = "󰍲"
      Ubuntu = "󰕈"
      SUSE = ""
      Raspbian = "󰐿"
      Mint = "󰣭"
      Macos = "󰀵"
      Manjaro = ""
      Linux = "󰌽"
      Gentoo = "󰣨"
      Fedora = "󰣛"
      Alpine = ""
      Amazon = ""
      Android = ""
      Arch = "󰣇"
      Artix = "󰣇"
      EndeavourOS = ""
      CentOS = ""
      Debian = "󰣚"
      Redhat = "󱄛"
      RedHatEnterprise = "󱄛"
      Pop = ""

      [username]
      show_always = true
      style_user = "bg:color_orange fg:color_fg0"
      style_root = "bg:color_orange fg:color_fg0"
      format = '[ $user ]($style)'

      [directory]
      style = "fg:color_fg0 bg:color_yellow"
      format = "[ $path ]($style)"
      truncation_length = 3
      truncation_symbol = "…/"

      [directory.substitutions]
      "Documents" = "󰈙 "
      "Downloads" = " "
      "Music" = "󰝚 "
      "Pictures" = " "
      "Developer" = "󰲋 "

      [git_branch]
      symbol = ""
      style = "bg:color_aqua"
      format = '[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)'

      [git_status]
      style = "bg:color_aqua"
      format = '[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)'

      [nodejs]
      symbol = ""
      style = "bg:color_blue"
      format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

      [c]
      symbol = " "
      style = "bg:color_blue"
      format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

      [cpp]
      symbol = " "
      style = "bg:color_blue"
      format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

      [rust]
      symbol = ""
      style = "bg:color_blue"
      format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

      [golang]
      symbol = ""
      style = "bg:color_blue"
      format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

      [php]
      symbol = ""
      style = "bg:color_blue"
      format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

      [java]
      symbol = ""
      style = "bg:color_blue"
      format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

      [kotlin]
      symbol = ""
      style = "bg:color_blue"
      format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

      [haskell]
      symbol = ""
      style = "bg:color_blue"
      format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

      [python]
      symbol = ""
      style = "bg:color_blue"
      format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

      [docker_context]
      symbol = ""
      style = "bg:color_bg3"
      format = '[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)'

      [conda]
      style = "bg:color_bg3"
      format = '[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)'

      [pixi]
      style = "bg:color_bg3"
      format = '[[ $symbol( $version)( $environment) ](fg:color_fg0 bg:color_bg3)]($style)'

      [time]
      disabled = false
      time_format = "%R"
      style = "bg:color_bg1"
      format = '[[  $time ](fg:color_fg0 bg:color_bg1)]($style)'

      [line_break]
      disabled = false

      [character]
      disabled = false
      success_symbol = '[](bold fg:color_green)'
      error_symbol = '[](bold fg:color_red)'
      vimcmd_symbol = '[](bold fg:color_green)'
      vimcmd_replace_one_symbol = '[](bold fg:color_purple)'
      vimcmd_replace_symbol = '[](bold fg:color_purple)'
      vimcmd_visual_symbol = '[](bold fg:color_yellow)'
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
    shellAliases = {
      test = "echo test";
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles/#nixos";
      gdot = ''cd ~/dotfiles && git add . && git commit -m "auto: $(date +%F_%T)"'';
      lock = "swaylock -c 000000";
      vim = "nvim";
    };
  };

  programs.bash = {
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "fqian";
    userEmail = "francois.qian2@gmail.com";
  };

  programs.kitty = {
    enable = true;
    themeFile = "tokyonight";
    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = 12.0;
      background_opacity = "0.8";
      shell = "${pkgs.fish}/bin/fish";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec-once = [
        "waybar & hyprpaper & mako & hypridle"
      ];
      monitor = [
        "HDMI-A-1,1920x1080@239.96,0x0,1"
        "DP-1,3440x1440@240,auto-right,1"
      ];

      input = {
        kb_layout = "gb";
        kb_variant = "";
        kb_model = "";
        accel_profile = "adaptive";
        follow_mouse = 2;
        touchpad = {
          natural_scroll = "no";
          disable_while_typing = true;
          "tap-to-click" = false;
          scroll_factor = 0.7;
        };
        sensitivity = 0;
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
        blur = {enabled = false;};
      };

      animations = {
        enabled = false;
        first_launch_animation = true;
      };

      master = {
        allow_small_split = true;
        mfact = 0.70;
        inherit_fullscreen = false;
      };

      gestures.workspace_swipe = "off";

      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
      };

      windowrulev2 = ["suppressevent maximize, class:.*"];

      "$mainMod" = "Alt_L";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$browser" = "firefox-nightly";
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
  };

  programs.home-manager.enable = true;
}
