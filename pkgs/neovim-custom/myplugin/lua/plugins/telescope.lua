-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
-- https://github.com/nvim-telescope/telescope-file-browser.nvim/wiki/Configuration-Recipes

local actions = require("telescope.actions")
local fb_actions = require "telescope._extensions.file_browser.actions"
local opts = {
    require("telescope").setup({
        defaults = {
            -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            borderchars = { "", "", "", "", "", "", "", "" },
            preview = {
                filesize_limit = 0.3, -- MB
            },
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--trim"
            },
            file_ignore_patterns = { "node_modules", ".git/" },
            winblend = 0,
            mappings = {
                i = {},
                n = {
                    ["J"] = actions.preview_scrolling_down,
                    ["K"] = actions.preview_scrolling_up,
                },
            },
        },
        pickers = {
            find_files = {
                find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
            },
        },
        extensions = {
            frecency = {
                path_display = { "shorten" },
            },
            file_browser = {
                grouped = true,
                depth = 2,
                hidden = true,
                hijack_netrw = true,
                select_buffer = true,
                mappings = {
                    ["i"] = {},
                    ["n"] = {
                        ["c"] = fb_actions.create,
                        ["r"] = fb_actions.rename,
                        ["m"] = fb_actions.move,
                        ["y"] = fb_actions.copy,
                        ["d"] = fb_actions.remove,
                    },
                }
            },
        },
    }),
}

require("telescope").setup(opts)
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("frecency")

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>e", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files, opts)
vim.keymap.set("n", "<leader>g", require("telescope.builtin").live_grep, opts)
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers, opts)
vim.keymap.set("n", "<leader>h", require("telescope.builtin").help_tags, opts)
