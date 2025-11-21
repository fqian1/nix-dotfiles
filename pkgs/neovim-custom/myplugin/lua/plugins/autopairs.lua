require("nvim-autopairs").setup({
	enable_check_bracket_line = false,
	ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
	check_ts = true,
	ts_config = {
		lua = { "string" }, -- it will not add a pair on that treesitter node
	},
	require("nvim-autopairs.rule")("%", "%", "lua"):with_pair(require("nvim-autopairs.ts-conds").is_ts_node({ "string", "comment" })),
	require("nvim-autopairs.rule")("$", "$", "lua"):with_pair(require("nvim-autopairs.ts-conds").is_not_ts_node({ "function" })),
})
