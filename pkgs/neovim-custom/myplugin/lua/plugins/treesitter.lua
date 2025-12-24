-- https://github.com/nvim-treesitter/nvim-treesitter

require("nvim-treesitter.configs").setup({
	auto_install = false,
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
    Black       = "NONE", -- BG
    BrightBlack = 0,      -- Popup menu BG
    DarkGrey    = 14,     -- Selection BG
    Grey        = 8,      -- Invisible Text
    LightGrey   = 7,      -- Comments, LineNumbers
    OffWhite    = "NONE", -- FG
    White       = 15,     -- Bright FG
    Red         = 1,      -- Variables and errors
    Green       = 2,      -- Strings
    Yellow      = 3,      -- Types, Classes
    Blue        = 4,      -- Functions, ID's
    Magenta     = 5,      -- Keywords
    Cyan        = 6,      -- Regex, Escape Chars
    Orange      = 11,     -- Numbers, Bools, Consts, Warn
    Maroon      = 13,     -- Deprecated, Headers, Embedded
}

local ts_highlights = {
    -- 1. Identifiers & Variables
    ["@variable"]           = { ctermfg = colors.OffWhite },
    ["@variable.builtin"]   = { ctermfg = colors.Red },
    ["@variable.parameter"] = { ctermfg = colors.Red },
    ["@variable.member"]    = { ctermfg = colors.Red },

    -- 2. Functions & Methods
    ["@function"]           = { ctermfg = colors.Blue },
    ["@function.builtin"]   = { ctermfg = colors.Blue, bold = true },
    ["@function.method"]    = { ctermfg = colors.Blue },
    ["@function.macro"]     = { ctermfg = colors.Cyan },

    -- 3. Keywords & Control
    ["@keyword"]            = { ctermfg = colors.Magenta },
    ["@keyword.function"]   = { ctermfg = colors.Magenta },
    ["@keyword.operator"]   = { ctermfg = colors.Magenta },
    ["@keyword.return"]     = { ctermfg = colors.Magenta },
    ["@conditional"]        = { ctermfg = colors.Magenta },
    ["@repeat"]             = { ctermfg = colors.Magenta },

    -- 4. Types & Classes
    ["@type"]               = { ctermfg = colors.Yellow },
    ["@type.builtin"]       = { ctermfg = colors.Yellow },
    ["@type.definition"]    = { ctermfg = colors.Yellow },
    ["@constructor"]        = { ctermfg = colors.Blue }, -- Or Yellow, depending on preference

    -- 5. Constants & Literals
    ["@constant"]           = { ctermfg = colors.Orange },
    ["@constant.builtin"]   = { ctermfg = colors.Orange, bold = true },
    ["@string"]             = { ctermfg = colors.Green },
    ["@string.escape"]      = { ctermfg = colors.Cyan },
    ["@number"]             = { ctermfg = colors.Orange },
    ["@boolean"]            = { ctermfg = colors.Orange },

    -- 6. Punctuation & Tags
    ["@punctuation.delimiter"] = { ctermfg = colors.LightGrey },
    ["@punctuation.bracket"]   = { ctermfg = colors.OffWhite },
    ["@tag"]                   = { ctermfg = colors.Red },
    ["@tag.attribute"]         = { ctermfg = colors.Orange },
    ["@tag.delimiter"]         = { ctermfg = colors.LightGrey },

    -- 7. Comments & Documentation
    ["@comment"]               = { ctermfg = colors.LightGrey, italic = true },
    ["@text.uri"]              = { ctermfg = colors.Blue, underline = true },
}

for group, settings in pairs(ts_highlights) do
    vim.api.nvim_set_hl(0, group, settings)
end
