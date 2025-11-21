{pkgs, ...}: {
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
      set -g status-position top
      set -g status-justify absolute-centre
      set -g status-style bg=default
      set -g window-status-current-style "fg=orange bg=default bold"
      set -g status-left-length 99
      set -g status-right-length 99
      set -g status-right ""
      set -g status-left "#S"
      set -g focus-events on
      set-option -g window-style 'fg=default,bg=default'
      set-option -g window-active-style 'fg=white,bg=default'
      set-window-option -g pane-border-status off
      set -g pane-border-style "fg=#000000,bg=default"
      set -g pane-active-border-style "fg=#000000,bg=default"
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      bind-key -T copy-mode-vi 'C-h' if-shell -F '#{pane_at_left}'   {} { select-pane -L }
      bind-key -T copy-mode-vi 'C-j' if-shell -F '#{pane_at_bottom}' {} { select-pane -D }
      bind-key -T copy-mode-vi 'C-k' if-shell -F '#{pane_at_top}'    {} { select-pane -U }
      bind-key -T copy-mode-vi 'C-l' if-shell -F '#{pane_at_right}'  {} { select-pane -R }
    '';
  };
}
