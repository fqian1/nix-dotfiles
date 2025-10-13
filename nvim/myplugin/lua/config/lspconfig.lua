local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<Leader>l", require("lsp_lines").toggle, opts)
end

lsp.rust_analyzer.setup({
  on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = true,
            check = {
                command = "clippy",
            },
        },
    },
})

lsp.lua_ls.setup({
  on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lsp.jdtls.setup({
  on_attach = on_attach,
    capabilities = capabilities,
})

lsp.clangd.setup({
  on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "clangd" },
})

lsp.pyright.setup({
  on_attach = on_attach,
    capabilities = capabilities,
})

lsp.nil_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})


vim.diagnostic.config({
    virtual_text = false,
})
