{
  imports = [
    ../../modules/home-manager/starship.nix
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/gtk.nix
  ],
  config,
  pkgs,
  inputs,
  lib,
  ...
in let
  neovim-custom = import ../../pkgs/nvim/neovim.nix {
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
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.packages = with pkgs; [
    wget
    tree
    vim
    neovim-custom
    rust-analyzer
    lua-language-server
    clang-tools
    jdt-language-server
    pyright
    alejandra
    nil
    hyprland
    nerd-fonts.fira-code
    p7zip
    fzy
    fd
    ripgrep
    bat
    yazi
    hyperfine
    wofi
    obsidian
    qbittorrent
    wl-clipboard-rs
    blesh
    gemini-cli
  ];

  programs.wofi = {
    enable = true;
  };

  # programs.gemini-cli = { # Gemini-cli writes to the same file settings.json, so NRS will clobber the file. Just install gemini-cli in pkgs and let gemini handle settings itself
  #   enable = true;
  #   defaultModel = "gemini-2.5-pro";
  #   settings = {
  #     generationConfig = {
  #       temperature = 0.1;
  #     };
  #     fileFiltering.respectGitIgnore = true;
  #     includeDirectories = ["~/.dotfiles"];
  #   };
  # };

  #TODO: configure these. maybe
  programs.hyprshot.enable = true;
  programs.hyprlock.enable = true;
  services.hyprpaper.enable = true;
  services.hyprpolkitagent.enable = true;
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
        }
        {
          timeout = 330;
          on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        # { Computer won't wake up if this happens so whatever ill just turn it off myself
        #   timeout = 1800;
        #   on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
        #   # The 'after_sleep_cmd' in 'general' handles the resume
        # }
      ];
    };
  };

  programs.zoxide = {
    #TODO: Configure in bash - autocomp and suggestions
    enable = true;
    enableBashIntegration = true;
  };

  programs.zoxide = {
    # do I need this when fzy?
    enable = true;
    enableBashIntegration = true;
  };

  # programs.readline = { # Conflicts with ble.sh
  #   enable = true;
  #   variables = {
  #     editing-mode = "vi";
  #     show-mode-in-prompt = "on";
  #     keyseq-timeout = 1;
  #     vi-cmd-mode-string = "\\1\\e[2 q\\2[CMD]"; #FIX: Cursor doesn't change. maybe kitty issue
  #     vi-ins-mode-string = "\\1\\e[6 q\\2[INS]";
  #   };
  # };

  programs.tmux = {
    enable = true;
    escapeTime = 10;
    clock24 = true;
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
    ];
    extraConfig = ''
      vim_pattern='(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +''${vim_pattern}$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\\' select-pane -l
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellOptions = ["globstar" "extglob"];
    initExtra = ''
      source ${pkgs.blesh}/share/blesh/ble.sh
      set -o vi
      bind -m vi-command 'v': # disable pressing v in normal mode to start $editor

      fedit() {
        local file_to_edit
        file_to_edit=$(fd $@ . ~/.dotfiles -tf | fzy)

        if [[ -n "$file_to_edit" ]]; then
          vim "$file_to_edit"
        fi
      }
      bind -x '"\C-e":fedit'

      f() {
        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            selected=$( (fd . ~/work ~/projects --exact-depth 1 -td; echo ~/.dotfiles) | fzy)
        fi

        if [[ -z $selected ]]; then
            return 0
        fi

        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        if [[ -z $TMUX ]]; then
            if tmux has-session -t="$selected_name" 2>/dev/null; then
                tmux attach-session -t "$selected_name"
            else
                tmux new-session -s "$selected_name" -c "$selected" \; split-window -h -p 40
            fi
        else
            if tmux has-session -t="$selected_name" 2>/dev/null; then
                tmux switch-client -t "$selected_name"
            else
                tmux new-session -ds "$selected_name" -c "$selected" \; split-window -h -p 40
                tmux switch-client -t "$selected_name"
            fi
        fi
      }
      bind -m vi-insert -x '"\C-f":f'
      bind -m vi-command -x '"\C-f":f'
    '';

    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/#nixos";
      nrb = "sudo nixos-rebuild boot --flake ~/.dotfiles/#nixos && reboot";
      port = "cat /var/run/protonvpn-forwarded-port";
      gdot = ''cd ~/.dotfiles && git add . && git commit -m "auto: $(date +%F_%T)"'';
      vim = "nvim";
      ls = "ls -l";
    };
  };

  programs.git = {
    enable = true;
    userName = "fqian";
    userEmail = "francois.qian2@gmail.com";
  };

  programs.kitty = {
    enable = true;
    themeFile = "Constant_Perceptual_Luminosity_dark";
    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = 12.0;
      boxDrawingScale = "0.001, 1, 1.5, 2";
      undercurlStyle = "thin-sparse";
      background_opacity = "0.8";
      shell_integration = "enabled";
      allow_remote_control = true;
    };
    extraConfig = ''
      modify_font underline_position 9
      modify_font underline_thickness 150%
      modify_font strikethrough_position 2px
    '';
  };

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
        blur = {enabled = false;};
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

      windowrulev2 = ["suppressevent maximize, class:.*"];

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

  programs.home-manager.enable = true;
}
