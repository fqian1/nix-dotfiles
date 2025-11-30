-- https://deepwiki.com/folke/tokyonight.nvim/2.3-advanced-configuration

-- require("tokyonight").setup({
-- 	style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
-- 	light_style = "day",
-- 	transparent = true,
-- 	terminal_colors = true,
-- 	styles = {
-- 		comments = { italic = true },
-- 		keywords = { italic = true },
-- 		functions = {},
-- 		variables = {},
-- 		sidebars = "transparent",
-- 		floats = "transparent",
-- 	},
-- 	day_brightness = 0.4,
-- 	dim_inactive = true,
-- 	lualine_bold = true,
-- 	cache = true,
-- })
--
--
-- require("kanagawa").setup({
-- 	dimInactive = true,
-- 	theme = "dragon",
-- 	transparent = false,
-- 	overrides = not transparent and function(colors)
-- 		local theme = colors.theme
-- 		return {
-- 			TelescopeTitle = { fg = theme.ui.special, bold = true },
-- 			TelescopePromptNormal = { bg = theme.ui.bg_p1 },
-- 			TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
-- 			TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
-- 			TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
-- 			TelescopePreviewNormal = { bg = theme.ui.bg_dim },
-- 			TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
--
-- 			Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
-- 			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2, blend = vim.o.pumblend },
-- 			PmenuSbar = { bg = theme.ui.bg_m1 },
-- 			PmenuThumb = { bg = theme.ui.bg_p2 },
-- 		}
-- 	end or nil,
-- })

-- vim.cmd("colorscheme tokyonight")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
