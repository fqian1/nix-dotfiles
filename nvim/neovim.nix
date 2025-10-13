{
  symlinkJoin,
  neovim,
  makeWrapper,
  runCommandLocal,
  vimPlugins,
  lib,
}: let
  packageName = "mypackage";

  startPlugins = [
    vimPlugins.lz-n
    vimPlugins.undotree
    vimPlugins.crates-nvim
    vimPlugins.nvim-treesitter.withAllGrammars
    vimPlugins.nvim-treesitter-textobjects
    vimPlugins.nvim-treesitter-context
    vimPlugins.vim-matchup
    vimPlugins.nvim-autopairs
    vimPlugins.nvim-cmp
    vimPlugins.cmp-nvim-lsp
    vimPlugins.cmp-buffer
    vimPlugins.cmp-path
    vimPlugins.cmp-cmdline
    vimPlugins.cmp_luasnip
    vimPlugins.luasnip
    vimPlugins.friendly-snippets
    vimPlugins.lspkind-nvim
    vimPlugins.nvim-lspconfig
    vimPlugins.bufferline-nvim
    vimPlugins.nvim-web-devicons
    vimPlugins.kanagawa-nvim
    vimPlugins.conform-nvim
    vimPlugins.gitsigns-nvim
    vimPlugins.indent-blankline-nvim
    vimPlugins.lsp_lines-nvim
    vimPlugins.lualine-nvim
    vimPlugins.telescope-nvim
    vimPlugins.telescope-ui-select-nvim
    vimPlugins.telescope-frecency-nvim
    vimPlugins.telescope-file-browser-nvim
    vimPlugins.telescope-fzy-native-nvim
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

  ${
    lib.concatMapStringsSep
    "\n"
    (plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}")
    startPluginsWithDeps
  }
'';
in
  symlinkJoin {
    name = "neovim-custom";
    paths = [neovim.unwrapped];
    nativeBuildInputs = [makeWrapper];
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
      maintainers = [];
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
      teams = [];
    };
  }
