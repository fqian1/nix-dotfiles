local function on_attach(client, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
end

vim.lsp.config["*"] = {
	root_markers = { ".git" },
	on_attach = on_attach(),
}

vim.lsp.config["rust_analyzer"] = {
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
}
vim.lsp.enable("rust_analyzer")


require('lspconfig').harper_ls.setup {}
vim.lsp.enable("harper-ls")

vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("tinymist")
vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("cssls")
vim.lsp.enable("pyright")

vim.keymap.set("n", "L", function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual_lines" })

vim.diagnostic.config({ virtual_text = false })
