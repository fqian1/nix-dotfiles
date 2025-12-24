vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.autocmds")
require("config.keymaps")
require("config.options")
require("plugins.auto-brackets")
require("plugins.candy")
require("plugins.completion")
require("plugins.formatter")
require("plugins.lsp")
require("plugins.obsidian")
require("plugins.render-markdown")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.undotree")

