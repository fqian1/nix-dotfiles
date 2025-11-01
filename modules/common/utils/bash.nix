{ pkgs, ... }:
{
  home-manager.users.fqian =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        blesh
      ];
      programs.bash = {
        enable = true;
        enableCompletion = true;
        shellOptions = [
          "globstar"
          "extglob"
        ];
        initExtra = ''
          source ${pkgs.blesh}/share/blesh/ble.sh
          set -o vi
          bind -m vi-command 'v': # disable pressing v in normal mode to start $editor
          bind 'set keyseq-timeout 1'

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
                selected=$( (fd . ~/work ~/projects ~/temp --exact-depth 1 -td; echo ~/.dotfiles ) | fzy)
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
          cat = "bat";
          top = "btm";
          cd = "z";
        };
      };
    };
}
