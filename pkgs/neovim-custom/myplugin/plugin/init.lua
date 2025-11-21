vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("plugins.auto-pairs")
require("plugins.cmp")
require("plugins.conform")
require("plugins.crates")
require("plugins.gitsigns")
require("plugins.indentblankline")
require("plugins.tokyonight")
require("plugins.lspconfig")
require("plugins.lsplines")
require("plugins.lualine")
require("plugins.obsidian")
require("plugins.render-markdown")
require("plugins.telescope")
require("plugins.fidget")
require("plugins.treesitter")
require("plugins.undotree")
