{ pkgs, ... }:
let
  tmux-sessionizer = ./scripts/tmux-sessionizer.sh;
  init-rust-project = ./scripts/init-rust-project.sh;
  find-edit = ./scripts/find-edit.sh;
in
{
  home.packages = with pkgs; [
    blesh
    skim
    fd
    fzy
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

      source ${tmux-sessionizer}
      source ${init-rust-project}
      source ${find-edit}

      bind -m vi-insert '"\C-e":find-edit'
      bind -m vi-command '"\C-e":find-edit'
      bind -m vi-insert -x '"\C-f":tmux-sessionizer'
      bind -m vi-command -x '"\C-f":tmux-sessionizer'
    '';

    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/#nixos";
      hrs = "home-manager --flake ~/.dotfiles/#fqian@nixos";
      nrb = "sudo nixos-rebuild boot --flake ~/.dotfiles/#nixos && reboot";
      port = "cat /var/run/protonvpn-forwarded-port";
      gdot = ''cd ~/.dotfiles && git add . && git commit -m "auto: $(date +%F_%T)"'';
      lock = "swaylock -c 000000";
      tree = "tree -F --dirsfirst";
      vim = "nvim";
      ls = "ls -l";
    };
  };
}
