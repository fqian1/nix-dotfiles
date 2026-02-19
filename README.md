# NIX CONFIG!!!
 - how to build config
 1. boot into live minimal iso
 2. nixos-generate-configuration --no-file-systems and cp into hosts
 3. do hostid and put that hostid in configuration.nix
 4. edit hosts/the-host/disk-config.nix with correct drive
 5. ```bash ./install-nixos.sh``` or ```bash ./install-laptop.sh```

 - how to try out the config:
 1. clone the repo and cd in
 2. make sure home-manager is enabled! ```nix shell nixpkgs#home-manager```
 3. make sure programs.dwl module in my config is in your system config, cant put into home manager
 4. run ```home-manager switch --flake .#fqian@nixos```
 5. roll back  with ```home-manager switch --rollback```

# todo list:
 - finish configure mangowc, make everything suckless. foot (no ligatures, alternative?), wl clipboard, grim, slurp. media controls in fn keys.
 - use agenix for wireguard conf file and ssh
 - auto brightness wluma
 - split modules/home-manager/cli packages to dev pkgs like tmux and qol pkgs like starship
 - make dmenu script YOURSELF! dwl -> open floating term -> fd -> skim -> nohup $app &
 - make hardware agnostic (amd nvidia intel gpu cpu integrated graphics etc.)
 - create base16 -> ansi 255 script
 - configure iwd over wpa supplicant / nmcli make tui using scripts
 - configure laptop and desktop modules, laptop stuff like tlp, openssh configurations
 - configure rust analyzer expressionadjustmenthints
 - enable encryption with zfs
 - rice tty (256 font ansi colour), kmscon/patched font
 - base16 -> oklab -> stretch 6x6x6 (bisect) -> rippas/tps/linear -> monotonic cube spline greyscale ramp -> ansi255
 - fwupdmgr service / script
 - create overlays for tools/apps like ripgrep or compositor with compiler optimizations -O3 -march=native
 - add pkgs/overlays for bevy_cli, maybe pixieditor, lmms
 - try out different kernels? maybe the cachyos kernel?? blazingly fast.
 - configure impermanence for home directory so i can do imperative stuff 👹
 - oreboot -> linuxboot (payload + bootloader) -> GOBO SUPREMACY -> s6
 - syncthing
 - configure obsidian - automatic link discovery (smark connections), auto tagging

# BUGS:
 - long time for vim open .md files
 - status bar stays in neovim even tmux
 - mango doesnt run autostart.sh
 - indentblankline doesnt read the fukin highlight group, need to do :IBLDisable > :IBLEnable
 - guess-indent just doesnt work
 - tmux not handling transparency

# unrelated:
 - grex, newsboat, jrnl, ttyd, croc: cool cli tools
 - stui, btop, bottom, htop, atop, iftop, iotop, csysdig, nvtop, perf, wavemon, upower
 - nextcloud + homeserver.
 - coreboot + some payload.
 - https://github.com/pd3v/line
 - p = (1-p)^(n-1)

```
./
├── home-manager/
│   └── home.nix
├── hosts/
│   ├── nixos-desktop/
│   │   ├── configuration.nix
│   │   ├── disk-config.nix
│   │   └── hardware.nix
│   └── nixos-laptop/
│       ├── configuration.nix
│       ├── disk-config.nix
│       ├── hardware-configuration.nix
│       └── hardware.nix
├── modules/
│   ├── home-manager/
│   │   ├── cli/
│   │   │   ├── scripts/
│   │   │   │   ├── find-edit.sh
│   │   │   │   ├── init-rust-project.sh
│   │   │   │   └── tmux-sessionizer.sh
│   │   │   ├── bash.nix
│   │   │   ├── default.nix
│   │   │   ├── fastfetch.nix
│   │   │   ├── starship.nix
│   │   │   ├── tmux.nix
│   │   │   └── tools.nix
│   │   ├── desktop/
│   │   │   ├── applications/
│   │   │   │   ├── default.nix
│   │   │   │   ├── discord.nix
│   │   │   │   ├── foot.nix
│   │   │   │   ├── librewolf.nix
│   │   │   │   ├── lmms.nix
│   │   │   │   ├── obsidian.nix
│   │   │   │   └── qbittorrent.nix
│   │   │   ├── default.nix
│   │   │   ├── neowall.nix
│   │   │   └── theme.nix
│   │   └── default.nix
│   └── nixos/
│       ├── default.nix
│       ├── dwl.nix
│       ├── impermanence.nix
│       ├── nvidia.nix
│       └── vpn.nix
├── overlays/
│   ├── patches/
│   │   ├── dwl.c
│   │   ├── dwl.patch
│   │   ├── Makefile
│   │   ├── Makefile.patch
│   │   ├── misc.patch
│   │   └── patches.txt
│   ├── config.h
│   └── default.nix
├── pkgs/
│   ├── neovim-custom/
│   │   ├── myplugin/
│   │   │   ├── lua/
│   │   │   │   ├── config/
│   │   │   │   │   ├── autocmds.lua
│   │   │   │   │   ├── keymaps.lua
│   │   │   │   │   └── options.lua
│   │   │   │   └── plugins/
│   │   │   │       ├── autopairs.lua
│   │   │   │       ├── cmp.lua
│   │   │   │       ├── conform.lua
│   │   │   │       ├── crates.lua
│   │   │   │       ├── gitsigns.lua
│   │   │   │       ├── indentblankline.lua
│   │   │   │       ├── kanagawa.lua
│   │   │   │       ├── lspconfig.lua
│   │   │   │       ├── lsplines.lua
│   │   │   │       ├── lualine.lua
│   │   │   │       ├── obsidian.lua
│   │   │   │       ├── rendermarkdown.lua
│   │   │   │       ├── telescope.lua
│   │   │   │       ├── tmuxnavigator.lua
│   │   │   │       ├── treesitter.lua
│   │   │   │       └── undotree.lua
│   │   │   └── plugin/
│   │   │       └── init.lua
│   │   └── default.nix
│   ├── neowall/
│   │   └── default.nix
│   └── default.nix
├── flake.lock
├── flake.nix
├── install-desktop.sh
├── install-laptop.sh
└── README.md
```
