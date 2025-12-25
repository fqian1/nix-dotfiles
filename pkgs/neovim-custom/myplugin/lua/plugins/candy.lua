require("fidget").setup()
require("ibl").setup()

local colors = {
	Black = "NONE", -- BG
	BrightBlack = 0, -- Popup menu BG
	DarkGrey = 14, -- Selection BG
	Grey = 8, -- Invisible Text
	LightGrey = 7, -- Comments, LineNumbers
	OffWhite = "NONE", -- FG
	White = 15, -- Bright FG
	Red = 1, --  Variables and errors
	Green = 2, -- Strings
	Yellow = 3, -- Types, Classes
	Blue = 4, -- Functions, ID's
	Magenta = 5, -- Keywords
	Cyan = 6, -- Regex, Escape Chars
	Orange = 11, -- Numbers, Bools, Consts, Warn
	Maroon = 13, -- Deprecated, Headers, Embedded
}

vim.api.nvim_set_hl(0, "IblScope", { ctermfg = colors.Orange })
vim.api.nvim_set_hl(0, "IblIndent", { ctermfg = colors.Grey })

require("gitsigns").setup()

require("lualine").setup({
	options = {
		theme = "auto",
		icons_enabled = true,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
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
					max_duration = 150,
					min_duration = 150,
					easing = "outInBack",
					chars_for_max_duration = 0,
					to_color = "Normal",
					from_color = "DiffAdd",
				},
			},
			redo_mapping = "<c-r>",
		},
	},

	animations = {
		fade = {
			max_duration = 150, -- Maximum animation duration in ms
			min_duration = 150, -- Minimum animation duration in ms
			easing = "outInBack", -- outInElastic is pretty nice
			chars_for_max_duration = 0, -- Character count for max duration
			from_color = "Visual", -- Start color (highlight group or hex)
			to_color = "Normal", -- End color (highlight group or hex)
		},
	},
})
