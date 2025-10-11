{ config, pkgs, inputs, nvimConfigPkg, ... }:

{
  home.username = "fqian";
  home.homeDirectory = "/home/fqian";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    firefox
    tree
    vim
    ripgrep
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      test = "echo test";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos";
      vim = "nvim";
    };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs; [
      vimPlugins.undotree
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-textobjects
      vimPlugins.nvim-treesitter-context
      vimPlugins.vim-matchup
      vimPlugins.nvim-autopairs
      vimPlugins.nvim-cmp
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-buffer
      vimPlugins.cmp-path
      vimPlugins.cmp-cmdline
      vimPlugins.luasnip
      vimPlugins.friendly-snippets
      vimPlugins.lspkind-nvim
      vimPlugins.cmp_luasnip
      vimPlugins.nvim-lspconfig
      vimPlugins.bufferline-nvim
      vimPlugins.nvim-web-devicons
      vimPlugins.kanagawa-nvim
      vimPlugins.conform-nvim
      vimPlugins.gitsigns-nvim
      vimPlugins.indent-blankline-nvim
      vimPlugins.lsp_lines-nvim
      vimPlugins.lualine-nvim
      vimPlugins.telescope-nvim
      vimPlugins.telescope-ui-select-nvim
      vimPlugins.telescope-frecency-nvim
      vimPlugins.telescope-file-browser-nvim
      vimPlugins.telescope-fzy-native-nvim
      nvimConfigPkg
    ];
  };

  programs.git = {
    enable = true;
    userName = "fqian";
    userEmail = "francois.qian2@gmail.com";
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_familty = "FiraCode Nerd Font";
      font_size = 12.0;
      ackground_opacity = "0.8";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
  
    settings = {
      exec-once = [
        "waybar & hyprpaper & mako & hypridle"
      ];
      monitor = [
        "HDMI-A,1920x1080@144,0x0,1"
        "DP-1,3440x1440@240,auto-left,1"
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
        blur = { enabled = false; };
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
  
      windowrulev2 = [ "suppressevent maximize, class:.*" ];
  
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
