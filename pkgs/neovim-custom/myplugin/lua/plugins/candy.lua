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

require("tiny-glimmer").setup({
    autoreload = true,
    refresh_interval_ms = 4,
    text_change_batch_timeout_ms = 50,
    transparency_color = nil,
    overwrite = {
        auto_map = true,
        yank = {
            enabled = true,
            default_animation = "fade",
        },
        search = {
            enabled = true,
            default_animation = "fade",
            next_mapping = "n",
            prev_mapping = "N",
        },
        paste = {
            enabled = true,
            default_animation = "fade",
            paste_mapping = "p",
            Paste_mapping = "P",
        },
        undo = {
            enabled = true,
            default_animation = {
                name = "fade",
                settings = {
                    max_duration = 200,
                    min_duration = 200,
                    easing = "inCirc",
                    chars_for_max_duration = 0,
                    to_color = "DiffDelete",
                    from_color = "DiffDelete",
                },
            },
            undo_mapping = "u",
        },
        redo = {
            enabled = true,
            default_animation = {
                name = "fade",
                settings = {
                    max_duration = 200,
                    min_duration = 200,
                    easing = "inCirc",
                    chars_for_max_duration = 0,
                    to_color = "DiffAdd",
                    from_color = "DiffAdd",
                },
            },
            redo_mapping = "<c-r>",
        },
    },

    animations = {
        fade = {
            max_duration = 200,         -- Maximum animation duration in ms
            min_duration = 200,         -- Minimum animation duration in ms
            easing = "inCirc",          -- Easing function
            chars_for_max_duration = 0, -- Character count for max duration
            from_color = "Visual",      -- Start color (highlight group or hex)
            to_color = "Normal",        -- End color (highlight group or hex)
        },
    },
})
