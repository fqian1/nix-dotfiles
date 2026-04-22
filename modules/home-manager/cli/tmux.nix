{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fzy
  ];
  programs.tmux = {
    enable = true;
    escapeTime = 10;
    clock24 = true;
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
    extraConfig = ''
      set -g renumber-windows on
      set -g focus-events on
      set -sg escape-time 1
      set -g extended-keys on
      set -g allow-passthrough on
      set -g mode-style "reverse"
      set -g default-terminal "tmux-256color"

      set-option -g terminal-features "xterm*:clipboard:cc:extkeys"

      # status line (vim tpipeline)
      set -g status-left-length 99
      set -g status-right-length 99
      set -g status-right ""
      set -g status-left ""
      set -g window-status-current-style "fg=colour11 bg=default bold"
      set -g window-status-current-format " #S "
      set -g status-position bottom
      set -g status-justify absolute-centre
      set -g status-style bg=default

      # dim inactive windows
      set-option -g window-style        "fg=colour7,bg=default"
      set-option -g window-active-style "fg=default,bg=default"

      # invisible borders
      set -g pane-border-style          "fg=colour232,bg=default"
      set -g pane-active-border-style   "fg=colour232,bg=default"

      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
    '';
  };
}
