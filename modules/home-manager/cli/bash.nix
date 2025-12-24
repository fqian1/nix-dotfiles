{ pkgs, lib, ... }:
let
  tmux-sessionizer = builtins.readFile ./scripts/tmux-sessionizer.sh;
  test-colours = builtins.readFile ./scripts/test-colours.sh;
  find-edit = builtins.readFile ./scripts/find-edit.sh;
  blerc = builtins.readFile ./scripts/blerc;
  better-suspend = builtins.readFile ./scripts/better-suspend.sh;
in
{
  home.packages = with pkgs; [
    wlr-randr
    blesh
    fd
    fzy
    jq
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
      bind 'set keyseq-timeout 1'
      set -o vi

      source ${pkgs.blesh}/share/blesh/ble.sh
      ${blerc}

      ${tmux-sessionizer}
      ${find-edit}
      ${better-suspend}
      ${test-colours}

      bind -m vi-insert -x '"\C-e":find-edit'
      bind -m vi-command -x '"\C-e":find-edit'
      bind -m vi-insert -x '"\C-f":tmux-sessionizer'
      bind -m vi-command -x '"\C-f":tmux-sessionizer'

      FASTFETCH_FLAG="/dev/shm/fastfetch_ran"
      if [ ! -f "$FASTFETCH_FLAG" ]; then
          fastfetch
          touch "$FASTFETCH_FLAG"
      fi
    '';

    shellAliases = {
      sudo = "doas";
      nrs = "nh os switch ~/.dotfiles";
      hrs = "nh home switch ~/.dotfiles";
      nrsd = "doas nixos-rebuild switch --flake ~/.dotfiles/#desktop";
      nrsl = "doas nixos-rebuild switch --flake ~/.dotfiles/#laptop";
      nrbd = "doas nixos-rebuild build --flake ~/.dotfiles/#desktop";
      nrbl = "doas nixos-rebuild build --flake ~/.dotfiles/#laptop";
      # hrs = "home-manager switch --flake ~/.dotfiles/#fqian";
      port = "cat /var/run/protonvpn-forwarded-port";
      lock = "swaylock -c 000000";
      tree = "tree -F --dirsfirst";
      gitrb = "git rebase -i origin/main";
      vim = "nvim";
      ls = "ls -lapF --color=auto";
    };
  };
}
