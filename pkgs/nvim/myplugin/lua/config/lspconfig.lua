local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<Leader>l", require("lsp_lines").toggle, opts)
end

vim.lsp.config("rust_analyzer", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = { command = "clippy" },
    },
  },
})

vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = { diagnostics = { globals = { "vim" } } },
  },
})

vim.lsp.config("jdtls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("clangd", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "clangd" },
})

vim.lsp.config("pyright", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("nil_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.diagnostic.config({ virtual_text = false })

