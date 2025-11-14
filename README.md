# NIX CONFIG!!!
 - boot into live minimal iso
 - nixos-generate-configuration --no-file-systems
 - do hostid and put that hostid in configuration.nix
 - edit hosts/the-host/disk-config.nix with correct drive
 - how to try out the config:
 1. clone the repo and cd in
 2. make sure home-manager is enabled! ```nix shell nixpkgs#home-manager```
 3. run ```home-manager switch --flake .#fqian@nixos```
 4. rolle back  with ```home-manager switch --rollback```

# todo list:
 - migrate to dwl, make everything suckless. remember to change key repeat delay and repeat rate. foot, wl clipboard, grim, slurp. media controls in fn keys.
 - use agenix for wireguard conf file and ssh
 - split modules/home-manager/cli packages to dev pkgs like tmux and qol pkgs like starship
 - make dmenu script YOURSELF! dwl -> open floating term -> fd -> skim -> nohup $app &
 - make hardware agnostic (amd nvidia intel gpu cpu integrated graphics etc.)
 - rice with quickshell, stylix?
- configure laptop and desktop modules, laptop stuff like tlp, openssh configurations
 - create overlays for tools/apps like ripgrep or dwl with compiler optimizations -O3 -march=native
 - try out different kernels? maybe the cachyos kernel?? blazingly fast.
 - customise ble.sh, make normal mode block cursor, maybe replace starship with blesh prompt
 - fwupdmgr service / script
 - create a shader and use as desktop background monstercat smoke https://github.com/1ay1/neowall
 - add pkgs/overlays for bevy_cli, maybe pixieditor, lmms
 - configure impermanence for home directory so i can do imperative stuff 👹
 - INSTRUMENTALISM! PRAGMATISM! MINIMALISM! Lix.


p = (1-p)^(n-1)

# unrelated:
 - grex, newsboat, jrnl, ttyd, croc, bat: cool cli tools
 - stui, btop, bottom, htop, atop, iftop, iotop, csysdig, nvtop, perf, wavemon
 - coreboot + some payload. sixos
 - nextcloud + homeserver.
 - https://github.com/pd3v/line

```
./
├── home-manager/
│   └── home.nix
├── hosts/
│   └── nixos/
│       ├── configuration.nix
│       ├── disk-config.nix
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
│   │   │   ├── hyprland.nix
│   │   │   ├── neowall.nix
│   │   │   └── theme.nix
│   │   └── default.nix
│   └── nixos/
│       ├── default.nix
│       ├── impermanence.nix
│       └── vpn.nix
├── overlays/
│   └── default.nix
├── pkgs/
│   ├── neowall/
│   │   └── default.nix
│   ├── nvim/
│   │   ├── myplugin/
│   │   │   ├── lua/
│   │   │   │   ├── config/
│   │   │   │   │   ├── autocmds.lua
│   │   │   │   │   ├── keymaps.lua
│   │   │   │   │   └── options.lua
│   │   │   │   └── plugins/
│   │   │   │       ├── autopairs.lua
│   │   │   │       ├── bufferline.lua
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
│   │   ├── default.nix
│   │   └── neovim.nix
│   └── default.nix
├── flake.lock
├── flake.nix
├── install.sh
└── README.md


```
