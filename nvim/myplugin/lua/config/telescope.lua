local actions = require('telescope.actions')
local opts = {
  require('telescope').setup({
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
      },
      file_ignore_patterns = { "node_modules", ".git/" },
      winblend = 0,
      mappings = {
        i = {},
        n = {
          ["x"] = actions.select_horizontal,
          ["v"] = actions.select_vertical,
          ["t"] = actions.select_tab,
          ["J"] = actions.preview_scrolling_down,
          ["K"] = actions.preview_scrolling_up,
        }
      }
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      frecency = {
        default_workspace = 'CWD',
        show_scores = true,
        show_unindexed = false,
        ignore_patterns = { "*.git/*", "*/tmp/*" },
      },
      file_browser = {
        hijack_netrw = true,
        hidden = true,
        respect_gitignore = false,
        select_buffer = true,
        search_dirs = { "src", "include" },
        recurse_subdirs = true,
      },
    }
  })
}

require('telescope').setup(opts)
require('telescope').load_extension('ui-select')
require('telescope').load_extension('fzy_native') -- Will be used automatically
require('telescope').load_extension('frecency')   -- Will be used automatically
require('telescope').load_extension('file_browser')
