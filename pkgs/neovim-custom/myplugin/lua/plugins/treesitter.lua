-- https://github.com/nvim-treesitter/nvim-treesitter
require('treesitter-modules').setup({
    auto_install = false,
    fold = {
        enable = true,
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = false,
			node_incremental = "v",
			scope_incremental = false,
			node_decremental = "V",
		},
	},
    indent = {
        enable = true,
    },
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
			selection_modes = {
				["@parameter.outer"] = "v",
				["@function.outer"] = "V",
				["@class.outer"] = "v",
			},
			include_surrounding_whitespace = true,
		},
	},
	matchup = { enable = true },
})

-- https://github.com/nvim-treesitter/nvim-treesitter-context?tab=readme-ov-file#configuration
require("treesitter-context").setup({
	multiline_threshold = 4,
})

local colors = {
	Black = "NONE", -- BG
	BrightBlack = 0, -- UI Panels
	Red = 1, -- Variables
	Green = 2, -- Strings
	Yellow = 3, -- Classes
	Blue = 4, -- Functions
	Magenta = 5, -- Keywords
	Cyan = 6, -- Regex
	LightGrey = 7, -- Subtle text
	Grey = 8, -- Invisible chars
	Orange = 11, -- Integers, Consts
	DarkGrey = 12, -- Highlighted lines
	Maroon = 13, -- Deprecated
	White = 15, -- Emphasis
	OffWhite = "NONE", -- FG
}

local ts_highlights = {
	-- 1. Identifiers & Variables
	["@variable"] = { ctermfg = colors.OffWhite }, -- Local vars
	["@variable.builtin"] = { ctermfg = colors.Red }, -- 'this', 'self'
	["@variable.parameter"] = { ctermfg = colors.Red },
	["@variable.member"] = { ctermfg = colors.Red }, -- Object properties
	["@property"] = { ctermfg = colors.Red }, -- Missing in your list (maps to member)

	-- 2. Functions & Methods
	["@function"] = { ctermfg = colors.Blue },
	["@function.builtin"] = { ctermfg = colors.Blue, bold = true },
	["@function.method"] = { ctermfg = colors.Blue },
	["@function.macro"] = { ctermfg = colors.Cyan },

	-- 3. Keywords & Control
	["@keyword"] = { ctermfg = colors.Magenta },
	["@keyword.function"] = { ctermfg = colors.Magenta },
	["@keyword.operator"] = { ctermfg = colors.Magenta },
	["@keyword.import"] = { ctermfg = colors.Maroon }, -- Specific for includes/requires
	["@operator"] = { ctermfg = colors.Magenta }, -- +, -, *, =
	["@conditional"] = { ctermfg = colors.Magenta },
	["@repeat"] = { ctermfg = colors.Magenta },

	-- 4. Types & Classes
	["@type"] = { ctermfg = colors.Yellow },
	["@type.builtin"] = { ctermfg = colors.Yellow },
	["@type.definition"] = { ctermfg = colors.Yellow },
	["@module"] = { ctermfg = colors.Yellow }, -- Namespaces/Modules
	["@constructor"] = { ctermfg = colors.Blue },

	-- 5. Constants & Literals
	["@constant"] = { ctermfg = colors.Orange },
	["@constant.builtin"] = { ctermfg = colors.Orange, bold = true },
	["@string"] = { ctermfg = colors.Green },
	["@string.escape"] = { ctermfg = colors.Cyan },
	["@number"] = { ctermfg = colors.Orange },
	["@boolean"] = { ctermfg = colors.Orange },

	-- 6. Punctuation & Tags
	["@punctuation"] = { ctermfg = colors.OffWhite },
	["@punctuation.delimiter"] = { ctermfg = colors.OffWhite },
	["@punctuation.bracket"] = { ctermfg = colors.OffWhite },

	["@tag"] = { ctermfg = colors.Red },
	["@tag.attribute"] = { ctermfg = colors.Blue }, -- FIXED: Palette says Blue = Attribute IDs
	["@tag.delimiter"] = { ctermfg = colors.Maroon }, -- FIXED: Palette says Maroon = Embedded Tags

	-- 7. Markup (Markdown / Help)
	["@markup.heading"] = { ctermfg = colors.Maroon, bold = true }, -- Palette says Maroon = Headers
	["@markup.strong"] = { bold = true },
	["@markup.italic"] = { italic = true },
	["@markup.link"] = { ctermfg = colors.Blue, underline = true },
	["@markup.link.label"] = { ctermfg = colors.Green },
	["@markup.raw"] = { ctermfg = colors.Green }, -- Code blocks

	-- 8. Comments
	["@comment"] = { ctermfg = colors.LightGrey, italic = true },
	["@text.uri"] = { ctermfg = colors.Blue, underline = true },
}

for group, settings in pairs(ts_highlights) do
	vim.api.nvim_set_hl(0, group, settings)
end

vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })
