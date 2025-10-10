return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	config = function()
		vim.keymap.set("n", "L", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
	end,
}
