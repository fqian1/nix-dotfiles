require("fidget").setup()
require("ibl").setup()

vim.api.nvim_set_hl(0, "IblScope", { ctermfg = 11 })
vim.api.nvim_set_hl(0, "IblIndent", { ctermfg = 8 })

require("gitsigns").setup()

require("lualine").setup({
	options = {
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
})

