require("tokyonight").setup({
	style = "moon", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
	light_style = "day",
	transparent = true,
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		sidebars = "transparent",
		floats = "transparent",
	},
	day_brightness = 0.4,
	dim_inactive = true,
	lualine_bold = false,
	cache = true,
})
vim.cmd("colorscheme tokyonight")
