{
  symlinkJoin,
  neovim-unwrapped,
  makeWrapper,
  runCommandLocal,
  vimPlugins,
  lib,
  alejandra,
  ripgrep,
  fd,
  prettier,
  rustfmt,
  ruff,
  shfmt,
  stylua,
  lua-language-server,
  yaml-language-server,
  rust-analyzer,
  bash-language-server,
  vscode-css-languageserver,
  pyright,
  nil,
  tree-sitter,
}: let
  packageName = "mypackage";

  startPlugins = [
    # Appearance
    vimPlugins.gitsigns-nvim
    vimPlugins.nvim-web-devicons
    vimPlugins.indent-blankline-nvim
    vimPlugins.lualine-nvim
    # LSP
    vimPlugins.nvim-lspconfig
    # Treesitter
    vimPlugins.treesitter-modules-nvim
    vimPlugins.nvim-treesitter-textobjects
    vimPlugins.nvim-treesitter-textsubjects
    vimPlugins.nvim-treesitter-sexp
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
    vimPlugins.mini-align
    # QOL
    vimPlugins.vim-matchup
    vimPlugins.nvim-autopairs
    # Misc
    vimPlugins.fidget-nvim
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
      ++ (foldPlugins (next.dependencies or []))
  ) [];

  startPluginsWithDeps = lib.unique (foldPlugins startPlugins);

  packpath = runCommandLocal "packpath" {} ''
    mkdir -p $out/pack/${packageName}/{start,opt}

    ln -vsfT ${./myplugin} $out/pack/${packageName}/start/myplugin

    ${lib.concatMapStringsSep "\n" (
        plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}"
      )
      startPluginsWithDeps}
  '';

  externalPackages = [
    alejandra
    ripgrep
    fd
    prettier
    rustfmt
    ruff
    shfmt
    stylua
    lua-language-server
    yaml-language-server
    rust-analyzer
    bash-language-server
    vscode-css-languageserver
    pyright
    nil
    tree-sitter
  ];
in
  symlinkJoin {
    name = "neovim-custom";
    paths = [neovim-unwrapped];
    nativeBuildInputs = [makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --add-flags '-u' \
        --add-flags 'NORC' \
        --add-flags '--cmd' \
        --add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
        --set-default NVIM_APPNAME nvim-custom \
        --prefix PATH : "${lib.makeBinPath externalPackages}"
    '';

    passthru = {
      inherit packpath;
    };
    meta = {
      description = "my nvim config";
      maintainers = [];
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
      teams = [];
    };
  }
