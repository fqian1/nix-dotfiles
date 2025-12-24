{
  symlinkJoin,
  neovim-unwrapped,
  makeWrapper,
  runCommandLocal,
  vimPlugins,
  lib,
}:
let
  packageName = "mypackage";

  startPlugins = [
    # Appearance
    vimPlugins.kanagawa-nvim
    vimPlugins.tokyonight-nvim
    vimPlugins.gitsigns-nvim
    vimPlugins.tiny-glimmer-nvim
    vimPlugins.nvim-web-devicons
    vimPlugins.indent-blankline-nvim
    vimPlugins.lualine-nvim
    # LSP
    vimPlugins.nvim-lspconfig
    # Treesitter
    vimPlugins.nvim-treesitter.withAllGrammars
    vimPlugins.nvim-treesitter-textobjects
    vimPlugins.nvim-treesitter-context
    # Completion
    vimPlugins.blink-cmp
    # Fuzzy Find
    vimPlugins.telescope-nvim
    vimPlugins.telescope-ui-select-nvim
    vimPlugins.telescope-frecency-nvim
    vimPlugins.telescope-fzy-native-nvim
    vimPlugins.telescope-file-browser-nvim
    # Format
    vimPlugins.conform-nvim
    vimPlugins.guess-indent-nvim
    vimPlugins.tabular
    # QOL
    vimPlugins.vim-matchup
    vimPlugins.nvim-autopairs
    # Misc
    vimPlugins.fidget-nvim # notifications
    vimPlugins.obsidian-nvim
    vimPlugins.render-markdown-nvim
    vimPlugins.undotree
    vimPlugins.vim-tpipeline
    vimPlugins.vim-tmux-navigator
    vimPlugins.colorizer
  ];

  foldPlugins = builtins.foldl' (
    acc: next:
    acc
    ++ [
      next
    ]
    ++ (foldPlugins (next.dependencies or [ ]))
  ) [ ];

  startPluginsWithDeps = lib.unique (foldPlugins startPlugins);

  packpath = runCommandLocal "packpath" { } ''
    mkdir -p $out/pack/${packageName}/{start,opt}

    ln -vsfT ${./myplugin} $out/pack/${packageName}/start/myplugin

    ${lib.concatMapStringsSep "\n" (
      plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}"
    ) startPluginsWithDeps}
  '';
in
symlinkJoin {
  name = "neovim-custom";
  paths = [ neovim-unwrapped ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/nvim \
      --add-flags '-u' \
      --add-flags 'NORC' \
      --add-flags '--cmd' \
      --add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
      --set-default NVIM_APPNAME nvim-custom
  '';

  passthru = {
    inherit packpath;
  };
  meta = {
    description = "my nvim config";
    maintainers = [ ];
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    teams = [ ];
  };
}
