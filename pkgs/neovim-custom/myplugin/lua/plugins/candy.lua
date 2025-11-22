require("fidget").setup()
require("crates").setup()
require("ibl").setup()

require("gitsigns").setup()

require("lsp_lines").setup()
vim.keymap.set("n", "L", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
vim.diagnostic.config({ virtual_text = false })

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
    }
})
