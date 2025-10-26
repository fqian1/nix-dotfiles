This repository contains personal NixOS and macOS (Darwin) configurations managed with Nix Flakes. The goal is to create a reproducible and declarative system environment.

**This is a work in progress.** The configurations are not yet complete and have not been fully tested.

./
├── flake.lock
├── @./flake.nix
├── GEMINI.md
├── hosts/
│   ├── darwin/
│   │   └── default.nix
│   └── nixos/
│       ├── @./hosts/nixos/default.nix
│       ├── @./hosts/nixos/disk-config.nix
│       └── @./hosts/nixos/hardware.nix
├── modules/
│   ├── common/
│   │   ├── default.nix
│   │   ├── development/
│   │   │   ├── default.nix
│   │   │   ├── git.nix
│   │   │   └── packages.nix
│   │   ├── home-manager/
│   │   │   └── default.nix
│   │   ├── system.nix
│   │   └── utils/
│   │       ├── bash.nix
│   │       ├── bat.nix
│   │       ├── bottom.nix
│   │       ├── default.nix
│   │       ├── direnv.nix
│   │       ├── eza.nix
│   │       ├── kitty.nix
│   │       ├── nh.nix
│   │       ├── packages.nix
│   │       ├── ripgrep.nix
│   │       ├── ssh.nix
│   │       ├── starship.nix
│   │       ├── tmux.nix
│   │       ├── yazi.nix
│   │       └── zoxide.nix
│   ├── darwin/
│   │   ├── default.nix
│   │   └── system.nix
│   └── nixos/
│       ├── @./modules/nixos/default.nix
│       ├── desktop/
│       │   ├── applications/
│       │   │   ├── default.nix
│       │   │   ├── discord.nix
│       │   │   ├── firefox.nix
│       │   │   ├── lmms.nix
│       │   │   ├── obsidian.nix
│       │   │   └── qbittorrent.nix
│       │   ├── audio/
│       │   │   └── default.nix
│       │   ├── default.nix
│       │   ├── desktop-environment/
│       │   │   ├── default.nix
│       │   │   ├── hypridle.nix
│       │   │   ├── hyprland.nix
│       │   │   ├── hyprlock.nix
│       │   │   ├── hyprpaper.nix
│       │   │   ├── wofi.nix
│       │   │   └── xdg.nix
│       │   └── theme/
│       │       └── default.nix
│       ├── impermanence/
│       │   ├── default.nix
│       │   ├── impermanence.nix
│       │   └── persistence.nix
│       ├── services/
│       │   ├── default.nix
│       │   └── vpn.nix
│       └── @./modules/nixos/system.nix
└── pkgs/
    ├── @./pkgs/default.nix
    └── nvim/
        ├── @./pkgs/nvim/default.nix
        ├── myplugin/
        │   ├── config/
        │   │   ├── autocmds.lua
        │   │   ├── keymaps.lua
        │   │   └── options.lua
        │   ├── init.lua
        │   └── plugins/
        │       ├── autobrackets.lua
        │       ├── autopairs.lua
        │       ├── bufferline.lua
        │       ├── cmp.lua
        │       ├── conform.lua
        │       ├── crates.lua
        │       ├── gitsigns.lua
        │       ├── indentblankline.lua
        │       ├── indentline.lua
        │       ├── kanagawa.lua
        │       ├── lspconfig.lua
        │       ├── lsplines.lua
        │       ├── lualine.lua
        │       ├── obsidian.lua
        │       ├── rendermarkdown.lua
        │       ├── telescope.lua
        │       ├── tmuxnavigator.lua
        │       ├── treesitter.lua
        │       └── undotree.lua
        └── @./pkgs/nvim/neovim.nix

todo list:
fix up the neovim wrapper and add to config
make hardware agnostic (amd nvidia intel gpu cpu etc.)
configure openssh and tailscale
replace tmux and kitty with
prune unneeded packages, keep it minimal
rice hyprland with quickshell
add the darwin configuration (finish nixos config first)
anything else?

unrelated:
grex, newsboat, jrnl, ttyd, croc: cool cli tools
