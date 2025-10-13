-- Autocommands for neovim

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
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

-- vim.api.nvim_create_autocmd("VimResized", {
--   group = vim.api.nvim_create_augroup("ResizeSplits", { clear = true }),
--   command = "tabdo wincmd ="
-- })

-- Set shiftwidth to 2 for lua files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.lua",
	callback = function()
		vim.opt.shiftwidth = 2
	end,
})

-- Set shiftwidth to 4 for all other files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*",
	callback = function()
		if vim.bo.filetype ~= "lua" then
			vim.opt.shiftwidth = 4
		end
	end,
})

for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
	local default_diagnostic_handler = vim.lsp.handlers[method]
	vim.lsp.handlers[method] = function(err, result, context, config)
		if err ~= nil and err.code == -32802 then
			return
		end
		return default_diagnostic_handler(err, result, context, config)
	end
end

-- -- Define highlight groups
-- vim.cmd("highlight ActiveWindowBorder guifg=#b35900 guibg=NONE")
-- vim.cmd("highlight InactiveWindowBorder guifg=#444444 guibg=NONE")
--
-- -- Automatically set border color based on active window
-- vim.api.nvim_create_augroup("ActiveWindowHighlight", { clear = true })
-- vim.api.nvim_create_autocmd("WinEnter", {
-- 	group = "ActiveWindowHighlight",
-- 	pattern = "*",
-- 	command = "setlocal winhighlight=Normal:Normal,FloatBorder:ActiveWindowBorder",
-- })
-- vim.api.nvim_create_autocmd("WinLeave", {
-- 	group = "ActiveWindowHighlight",
-- 	pattern = "*",
-- 	command = "setlocal winhighlight=Normal:Normal,FloatBorder:InactiveWindowBorder",
-- })
