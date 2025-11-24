{ pkgs, ... }:
let
  tmux-sessionizer = builtins.readFile ./scripts/tmux-sessionizer.sh;
  find-edit = builtins.readFile ./scripts/find-edit.sh;
  colorschemes = builtins.readFile ./scripts/colorschemes.sh;
  prompt = builtins.readFile ./scripts/prompt.sh;
in
{
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
      bind 'set keyseq-timeout 1'
      set -o vi

      ${tmux-sessionizer}
      ${find-edit}

      bind -m vi-insert -x '"\C-e":find-edit'
      bind -m vi-command -x '"\C-e":find-edit'
      bind -m vi-insert -x '"\C-f":tmux-sessionizer'
      bind -m vi-command -x '"\C-f":tmux-sessionizer'

      FASTFETCH_FLAG="/dev/shm/fastfetch_ran"
      if [ ! -f "$FASTFETCH_FLAG" ]; then
          fastfetch
          touch "$FASTFETCH_FLAG"
      fi

      source ${pkgs.blesh}/share/blesh/ble.sh
      # https://github.com/akinomyoga/ble.sh/blob/master/blerc.template

      bleopt prompt_eol_mark=
      bleopt exec_errexit_mark=
      bleopt exec_elapsed_enabled='sys+usr>=5*60*1000'

      ble-bind -m vi_imap -f 'C-m' accept-line
      ble-bind -m vi_nmap -f 'RET' accept-line
      ble-bind -m vi_imap -f 'RET' accept-line
      ble-bind -m vi_nmap -f 'C-m' accept-line

      ble-bind -m vi_nmap --cursor 2
      ble-bind -m vi_imap --cursor 5
      ble-bind -m vi_omap --cursor 4
      ble-bind -m vi_xmap --cursor 2
      ble-bind -m vi_cmap --cursor 0

      ${colorschemes}
      ${prompt}
    '';

    shellAliases = {
      nrsd = "sudo nixos-rebuild switch --flake ~/.dotfiles/#desktop";
      nrsl = "sudo nixos-rebuild switch --flake ~/.dotfiles/#laptop";
      nrbd = "sudo nixos-rebuild build --flake ~/.dotfiles/#desktop";
      nrbl = "sudo nixos-rebuild build --flake ~/.dotfiles/#laptop";
      hrs = "home-manager switch --flake ~/.dotfiles/#fqian";
      port = "cat /var/run/protonvpn-forwarded-port";
      lock = "swaylock -c 000000";
      tree = "tree -F --dirsfirst";
      gitrb = "git rebase -i origin/main";
      vim = "nvim";
      ls = "ls -l";
    };
  };
}
