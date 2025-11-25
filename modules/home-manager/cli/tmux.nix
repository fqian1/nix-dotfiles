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
      vim-tmux-navigator
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
      set -sg escape-time 1
      # set -g extended-keys on

      set-option -g window-style 'fg=#bbbbbb,bg=default'
      set-option -g window-active-style 'fg=white,bg=default'
      set-window-option -g pane-border-status off
      set -g pane-border-style "fg=#000000,bg=default"
      set -g pane-active-border-style "fg=#000000,bg=default"
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      vim_pattern='(\S+/)?g?\.?(view|l?n?vim?x?|fzy)(diff)?(-wrapped)?'
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +$${vim_pattern}$'"
      bind-key -n 'C-h' if-shell "$is_vim" { send-keys C-h } { if-shell -F '#{pane_at_left}'   {} { select-pane -L } }
      bind-key -n 'C-j' if-shell "$is_vim" { send-keys C-j } { if-shell -F '#{pane_at_bottom}' {} { select-pane -D } }
      bind-key -n 'C-k' if-shell "$is_vim" { send-keys C-k } { if-shell -F '#{pane_at_top}'    {} { select-pane -U } }
      bind-key -n 'C-l' if-shell "$is_vim" { send-keys C-l } { if-shell -F '#{pane_at_right}'  {} { select-pane -R } }

      bind-key -T copy-mode-vi 'C-h' if-shell -F '#{pane_at_left}'   {} { select-pane -L }
      bind-key -T copy-mode-vi 'C-j' if-shell -F '#{pane_at_bottom}' {} { select-pane -D }
      bind-key -T copy-mode-vi 'C-k' if-shell -F '#{pane_at_top}'    {} { select-pane -U }
      bind-key -T copy-mode-vi 'C-l' if-shell -F '#{pane_at_right}'  {} { select-pane -R }
    '';
  };
}
