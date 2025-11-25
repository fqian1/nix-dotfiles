-- https://cmp.saghen.dev/recipes.html

require("blink.cmp").setup({
    keymap = { preset = "super-tab" },
    completion = { ghost_text = { enabled = true } },
    cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
    }
})
