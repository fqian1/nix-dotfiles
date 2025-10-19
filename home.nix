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
    fzy #TODO: Customise?
    fd #TODO: Customise?
    ripgrep #TODO: Customise?
    bat #TODO: Customise?
    yazi #TODO: Customise?
    hyperfine
    wofi #TODO customise
    obsidian
    qbittorrent
    wl-clipboard-rs
    blesh # better bash
    gemini-cli
  ];

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
    gtk3.extraConfig = {
      "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "content.notify.interval" = 100000;

        # /** GFX ***/
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.skia-font-cache-size" = 20;

        # /** DISK CACHE ***/
        "browser.cache.disk.enable" = false;

        # /** MEMORY CACHE ***/
        "browser.sessionhistory.max_total_viewers" = 4;

        # /** MEDIA CACHE ***/
        "media.memory_cache_max_size" = 65536;
        "media.cache_readahead_limit" = 7200;
        "media.cache_resume_threshold" = 3600;

        # /** IMAGE CACHE ***/
        "image.mem.decode_bytes_at_a_time" = 32768;

        # /** NETWORK ***/
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.http.pacing.requests.enabled" = false;
        "network.dnsCacheExpiration" = 3600;
        "network.ssl_tokens_cache_capacity" = 10240;

        # /** SPECULATIVE LOADING ***/
        "network.http.speculative-parallel-limit" = 0;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.places.speculativeConnect.enabled" = false;
        "network.prefetch-next" = false;
        "network.predictor.enabled" = false;

        # /** EXPERIMENTAL ***/
        "layout.css.grid-template-masonry-value.enabled" = true;

        # /****************************************************************************
        #  * SECTION: SECUREFOX                                                       *
        # ****************************************************************************/
        # /** TRACKING PROTECTION ***/
        "privacy.trackingprotection.allow_list.baseline.enabled" = true;
        "privacy.trackingprotection.allow_list.convenience.enabled" = true;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.uitour.enabled" = false;
        "privacy.globalprivacycontrol.enabled" = true;

        # /** OCSP & CERTS / HPKP ***/
        "security.OCSP.enabled" = 0;
        "security.pki.crlite_mode" = 2;
        "security.csp.reporting.enabled" = false;

        # /** SSL / TLS ***/
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "security.tls.enable_0rtt_data" = false;

        # /** DISK AVOIDANCE ***/
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.sessionstore.interval" = 60000;

        # /** SHUTDOWN & SANITIZING ***/
        "browser.privatebrowsing.resetPBM.enabled" = true;
        "privacy.history.custom" = true;

        # /** SEARCH / URL BAR ***/
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
        "browser.search.separatePrivateDefault.ui.enabled" = true;
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.formfill.enable" = false;
        "network.IDN_show_punycode" = true;

        # /** PASSWORDS ***/
        "network.auth.subresource-http-auth-allow" = 1;

        # /** MIXED CONTENT + CROSS-SITE ***/
        "security.mixed_content.block_display_content" = true;
        "pdfjs.enableScripting" = false;

        # /** EXTENSIONS ***/
        "extensions.enabledScopes" = 5;

        # /** HEADERS / REFERERS ***/
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        # /** CONTAINERS ***/
        "privacy.userContext.ui.enabled" = true;

        # /** SAFE BROWSING ***/
        "browser.safebrowsing.downloads.remote.enabled" = false;

        # /** MOZILLA ***/
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;
        "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
        "browser.search.update" = false;
        "permissions.manager.defaultsUrl" = "";
        "extensions.getAddons.cache.enabled" = false;

        # /** TELEMETRY ***/
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "datareporting.usage.uploadEnabled" = false;

        # /** EXPERIMENTS ***/
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";

        # /** CRASH REPORTS ***/
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;

        # /****************************************************************************
        #  * SECTION: PESKYFOX                                                        *
        # ****************************************************************************/
        # /** MOZILLA UI ***/
        "browser.privatebrowsing.vpnpromourl" = "";
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.profiles.enabled" = true;

        # /** THEME ADJUSTMENTS ***/
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;
        "browser.privateWindowSeparation.enabled" = false; # WINDOWS

        # /** AI ***/
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;

        # /** FULLSCREEN NOTICE ***/
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.timeout" = 0;

        # /** URL BAR ***/
        "browser.urlbar.trending.featureGate" = false;

        # /** NEW TAB PAGE ***/
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;

        # /** POCKET ***/
        "extensions.pocket.enabled" = false;

        # /** DOWNLOADS ***/
        "browser.download.manager.addToRecentDocs" = false;

        # /** PDF ***/
        "browser.download.open_pdf_attachments_inline" = true;

        # /** TAB BEHAVIOR ***/
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.menu.showViewImageInfo" = true;
        "findbar.highlightAll" = true;
        "layout.word_select.eat_space_to_next_word" = false;

        # /****************************************************************************
        #  * START: MY OVERRIDES                                                      *
        # ****************************************************************************/
        # Note: Nix will automatically use these values, overriding any identical
        # keys defined earlier in this set.
        "signon.formlessCapture.enabled" = true;
        "signon.privateBrowsingCapture.enabled" = true;
        "signon.autofillForms" = true;
        "signon.rememberSignons" = true;
        "editor.truncate_user_pastes" = true;
        "browser.contentblocking.category" = "standard";
        # "browser.newtabpage.activity-stream.showSponsoredTopSites" is already false
        # "browser.newtabpage.activity-stream.feeds.section.topstories" is already false
        # "browser.newtabpage.activity-stream.showSponsored" is already false
        "identity.fxaccounts.enabled" = true;

        # /****************************************************************************
        #  * SECTION: SMOOTHFOX                                                       *
        # ****************************************************************************/
        "general.smoothScroll" = true; # DEFAULT
        "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
        "general.smoothScroll.msdPhysics.enabled" = true;
        "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
        "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2.0;
        "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
        "general.smoothScroll.currentVelocityWeighting" = 1.0;
        "general.smoothScroll.stopDecelerationWeighting" = 1.0;
        "mousewheel.default.delta_multiplier_y" = 300;
      };
    };
  };

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

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      format = ''[$os$username](color_orange)[$directory](color_yellow)[$git_branch$git_status](color_aqua)[$c$cpp$rust$golang$nodejs$php$java$kotlin$haskell$python](color_blue)[$docker_context$conda$pixi](color_bg3)[$time](color_bg1)$character'';

      palette = "gruvbox_dark";

      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };

      os = {
        disabled = false;
        style = "fg:color_orange";
        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          EndeavourOS = "";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
          Pop = "";
        };
      };

      username = {
        show_always = true;
        style_user = "fg:color_orange";
        style_root = "fg:color_orange";
        format = "\\[[$user]($style)\\]";
      };

      directory = {
        style = "fg:color_yellow";
        format = "\\[[$path]($style)\\]";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };

      git_branch = {
        symbol = "";
        style = "fg:color_aqua";
        format = "\\[[$symbol $branch]($style)";
      };

      git_status = {
        style = "fg:color_aqua";
        format = "[($all_status$ahead_behind )]($style)\\]";
      };

      nodejs = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      c = {
        symbol = " ";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      cpp = {
        symbol = " ";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      rust = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      golang = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      php = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      java = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      kotlin = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      haskell = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      python = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      docker_context = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($context)]($style)\\]";
      };

      conda = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($environment)]($style)\\]";
      };

      pixi = {
        style = "fg:color_blue";
        format = "\\[[$symbol($version)($environment)]($style)\\]";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "fg:color_bg3";
        format = "\\[[ $time]($style)\\]";
      };

      line_break = {
        disabled = true;
      };

      character = {
        disabled = false;
        success_symbol = "[](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
        vimcmd_symbol = "[](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
        vimcmd_replace_symbol = "[](bold fg:color_purple)";
        vimcmd_visual_symbol = "[](bold fg:color_yellow)";
      };
    };
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
