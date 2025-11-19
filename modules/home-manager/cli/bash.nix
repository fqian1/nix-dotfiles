{pkgs, ...}: let
  tmux-sessionizer = builtins.readFile ./scripts/tmux-sessionizer.sh;
  init-rust-project = builtins.readFile ./scripts/init-rust-project.sh;
  find-edit = builtins.readFile ./scripts/find-edit.sh;
  max-refresh = builtins.readFile ./scripts/max-refresh.sh; # no longer needed?
in {
  home.packages = with pkgs; [
    wlr-randr
    blesh
    skim
    fd
    fzy
  ];

  programs.fastfetch.enable = true;

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
      # bind -m vi-command 'v' # disable pressing v in normal mode to start $editor
      bind 'set keyseq-timeout 1'

      ${tmux-sessionizer}
      ${init-rust-project}
      ${find-edit}

      bind -m vi-insert -x '"\C-e":find-edit'
      bind -m vi-command -x '"\C-e":find-edit'
      bind -m vi-insert -x '"\C-f":tmux-sessionizer'
      bind -m vi-command -x '"\C-f":tmux-sessionizer'

      fastfetch
      #
      # FASTFETCH_FLAG="/dev/shm/fastfetch_ran"
      # if [ ! -f "$FASTFETCH_FLAG" ]; then
      #     fastfetch
      #     touch "$FASTFETCH_FLAG"
      # fi
    '';

    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/#nixos";
      hrs = "home-manager switch --flake ~/.dotfiles/#fqian@nixos";
      nrb = "sudo nixos-rebuild build --flake ~/.dotfiles/#nixos";
      port = "cat /var/run/protonvpn-forwarded-port";
      gdot = ''cd ~/.dotfiles && git add . && git commit -m "auto: $(date +%F_%T)"'';
      lock = "swaylock -c 000000";
      tree = "tree -F --dirsfirst";
      vim = "nvim";
      ls = "ls -l";
    };
  };
}
