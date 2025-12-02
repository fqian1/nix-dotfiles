require("fidget").setup()
require("ibl").setup()

require("gitsigns").setup()

require("lualine").setup({
    options = {
        theme = 'auto',
        icons_enabled = true,
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
                    max_duration = 150,
                    min_duration = 150,
                    easing = "outInBack",
                    chars_for_max_duration = 0,
                    to_color = "Normal",
                    from_color = "#ff2222",
                },
            },
            undo_mapping = "u",
        },
        redo = {
            enabled = true,
            default_animation = {
                name = "fade",
                settings = {
                    max_duration = 150,
                    min_duration = 150,
                    easing = "outInBack",
                    chars_for_max_duration = 0,
                    to_color = "Normal",
                    from_color = "#22ff22",
                },
            },
            redo_mapping = "<c-r>",
        },
    },

    animations = {
        fade = {
            max_duration = 150,         -- Maximum animation duration in ms
            min_duration = 150,         -- Minimum animation duration in ms
            easing = "outInBack",       -- outInElastic is pretty nice
            chars_for_max_duration = 0, -- Character count for max duration
            from_color = "#ffffaa",     -- Start color (highlight group or hex)
            to_color = "Normal",        -- End color (highlight group or hex)
        },
    },
})
