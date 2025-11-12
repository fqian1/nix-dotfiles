{pkgs, ...}: let
  tmux-sessionizer = builtins.readFile ./scripts/tmux-sessionizer.sh;
  init-rust-project = builtins.readFile ./scripts/init-rust-project.sh;
  find-edit = builtins.readFile ./scripts/find-edit.sh;
in {
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

      ${tmux-sessionizer}
      ${init-rust-project}
      ${find-edit}

      bind -m vi-insert '"\C-e":find-edit'
      bind -m vi-command '"\C-e":find-edit'
      bind -m vi-insert -x '"\C-f":tmux-sessionizer'
      bind -m vi-command -x '"\C-f":tmux-sessionizer'
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
