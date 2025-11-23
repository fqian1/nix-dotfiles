-- https://github.com/nvim-treesitter/nvim-treesitter

require("nvim-treesitter.configs").setup({
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = false,
			node_incremental = "v",
			scope_incremental = false,
			node_decremental = "V",
		},
	},
	indent = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
			selection_modes = {
				["@parameter.outer"] = "v",
				["@function.outer"] = "V",
				["@class.outer"] = "v",
			},
			include_surrounding_whitespace = true,
		},
	},
	matchup = { enable = true },
})

-- https://github.com/nvim-treesitter/nvim-treesitter-context?tab=readme-ov-file#configuration
require("treesitter-context").setup({
	multiline_threshold = 4,
})
