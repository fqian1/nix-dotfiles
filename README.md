# todo list:
 - minimalise hosts/nixos, maybe add hosts/common/ for non user specific things
 - clear separation between users.users and home-manager.users, and home-manager common modules and home-manager user specific (e.g. ssh contains PII vs starship)
 - make hardware agnostic (amd nvidia intel gpu cpu etc.)
 - configure ssh and openssh service for users.users and home-manager.users. no need for cloudflared or tailscale
 - prune unneeded packages, keep it minimal. fzf, fzy and skim all same thing. use find over fd? maybe keep fd. bat, zoxide can go. maybe even ripgrep? but then have to edit bash scripts. what to do.
 - create dev shells. how it works? direnv?
 - configure impermanence for home directory so i can do imperative stuff *ogre emoji*
 - add pkgs/overlays for bevy_cli, maybe pixieditor, lmms
 - migrate to dwl, make everything suckless. remember to change key repeat delay and repeat rate
 - rice with quickshell, stylix?
 - add programs: blender gimp audacity obs-studio
 - create a shader and use as desktop background monstercat smoke https://github.com/1ay1/neowall
 - fwupdmgr service / script
 - switch from firefox to librewolf. remember to add user.js config

# unrelated:
 - grex, newsboat, jrnl, ttyd, croc: cool cli tools
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
│   │   │   ├── bash.nix
│   │   │   ├── bat.nix
│   │   │   ├── bottom.nix
│   │   │   ├── default.nix
│   │   │   ├── direnv.nix
│   │   │   ├── eza.nix
│   │   │   ├── lazygit.nix
│   │   │   ├── nh.nix
│   │   │   ├── packages.nix
│   │   │   ├── ripgrep.nix
│   │   │   ├── starship.nix
│   │   │   ├── tmux.nix
│   │   │   ├── yazi.nix
│   │   │   └── zoxide.nix
│   │   ├── desktop/
│   │   │   ├── applications/
│   │   │   │   ├── default.nix
│   │   │   │   ├── discord.nix
│   │   │   │   ├── firefox.nix
│   │   │   │   ├── kitty.nix
│   │   │   │   ├── lmms.nix
│   │   │   │   ├── obsidian.nix
│   │   │   │   └── qbittorrent.nix
│   │   │   ├── default.nix
│   │   │   ├── hyprland.nix
│   │   │   └── theme.nix
│   │   └── default.nix
│   └── nixos/
│       ├── audio.nix
│       ├── default.nix
│       ├── impermanence.nix
│       ├── packages.nix
│       ├── vpn.nix
│       └── xdg.nix
├── overlays/
│   └── default.nix
├── pkgs/
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
