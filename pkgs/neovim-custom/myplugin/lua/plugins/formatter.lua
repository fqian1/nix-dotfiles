require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        nix = { "alejandra" },
        sh = { "shfmt" },
        rust = { "rustfmt" },
    },
})

require('guess-indent').setup()

vim.keymap.set({ "n", "v" }, "=", function()
    require("conform").format({
        async = true,
        lsp_fallback = true,
    })
end, {
    desc = "Format buffer/selection with conform",
})
