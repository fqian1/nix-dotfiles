vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Auto reload files when changed outside of neovim
vim.api.nvim_create_autocmd("FocusGained", {
	group = vim.api.nvim_create_augroup("AutoReload", { clear = true }),
	command = "checktime",
})

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
