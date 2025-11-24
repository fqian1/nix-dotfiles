local opts = { noremap = true, silent = true }

vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "=", vim.lsp.buf.format, opts)

vim.lsp.enable("rust-analyzer")
vim.lsp.enable("bash-language-server")
vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("jdtls")
vim.lsp.enable("clangd")
vim.lsp.enable("pyright")
