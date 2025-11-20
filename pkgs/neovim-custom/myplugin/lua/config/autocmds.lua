vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Autocommand that jumps to the last known cursor position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		-- Check if the last position mark (") is valid
		local last_pos = vim.fn.line("'\"")
		local total_lines = vim.fn.line("$")

		-- If the last position is valid and within the file, move the cursor there
		if last_pos > 0 and last_pos <= total_lines then
			vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
		end
	end,
})

-- Trim whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- Auto reload files when changed outside of neovim
vim.api.nvim_create_autocmd("FocusGained", {
	group = vim.api.nvim_create_augroup("AutoReload", { clear = true }),
	command = "checktime",
})

-- Auto save files when focus is lost
vim.api.nvim_create_autocmd("FocusLost", {
	group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
	pattern = "*",
	command = "silent! wa",
})

-- persistent folds
local persistent_folds_group = vim.api.nvim_create_augroup("PersistentFolds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
	group = persistent_folds_group,
	pattern = "?*",
	callback = function()
		vim.cmd.mkview()
	end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = persistent_folds_group,
	pattern = "?*",
	callback = function()
		-- Use pcall/loadview with modifiers to suppress errors if no view exists
		pcall(vim.cmd.loadview)
	end,
})

-- timing issues with lsp
for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
	local default_diagnostic_handler = vim.lsp.handlers[method]
	vim.lsp.handlers[method] = function(err, result, context, config)
		if err ~= nil and err.code == -32802 then
			return
		end
		return default_diagnostic_handler(err, result, context, config)
	end
end

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

-- Local shada
local function get_project_root()
	local root = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
	if root ~= "" then
		return root
	else
		return vim.fn.getcwd()
	end
end
local function set_project_shada()
	local project_root = get_project_root()
	local shada_hash = vim.fn.sha256(project_root)
	local shada_dir = vim.fn.stdpath("data") .. "/shada"
	local shada_file = shada_dir .. "/" .. shada_hash .. ".shada"
	vim.opt.shadafile = shada_file
end
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	group = vim.api.nvim_create_augroup("ProjectShaDa", { clear = true }),
	callback = set_project_shada,
})
