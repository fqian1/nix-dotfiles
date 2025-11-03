local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set marks using <leader> + number
map("n", "<leader>1", ':execute "normal! mA"<CR>', opts)
map("n", "<leader>2", ':execute "normal! mB"<CR>', opts)
map("n", "<leader>3", ':execute "normal! mC"<CR>', opts)
map("n", "<leader>4", ':execute "normal! mD"<CR>', opts)
map("n", "<leader>5", ':execute "normal! mE"<CR>', opts)
map("n", "<leader>6", ':execute "normal! mF"<CR>', opts)
map("n", "<leader>7", ':execute "normal! mG"<CR>', opts)
map("n", "<leader>8", ':execute "normal! mH"<CR>', opts)
map("n", "<leader>9", ':execute "normal! mI"<CR>', opts)
map("n", "<leader>0", ':execute "normal! mJ"<CR>', opts)

-- Jump to marks using Ctrl + number and jump to recent position
map("n", "<C-1>", "'A'\"", opts)
map("n", "<C-2>", "'B'\"", opts)
map("n", "<C-3>", "'C'\"", opts)
map("n", "<C-4>", "'D'\"", opts)
map("n", "<C-5>", "'E'\"", opts)
map("n", "<C-6>", "'F'\"", opts)
map("n", "<C-7>", "'G'\"", opts)
map("n", "<C-8>", "'H'\"", opts)
map("n", "<C-9>", "'I'\"", opts)
map("n", "<C-0>", "'J'\"", opts)

-- less jumpy navigation
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '>-2<CR>gv=gv", opts)
keymap("n", "J", " mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "{", "{zz", opts)
keymap("n", "}", "}zz", opts)

-- paste and delete to void register
keymap("x", "<leader>p", '"_dP', opts)
keymap("n", "<leader>d", '"_d', opts)
keymap("v", "<leader>d", '"_d', opts)

-- jump to next/previous diagnostic
keymap("n", "<leader>j", "<cmd>lnext<CR>zz", opts)
keymap("n", "<leader>k", "<cmd>lprev<CR>zz", opts)

-- unbind some keys
keymap("n", "Q", "<nop>", opts)
keymap("n", "<C-q>", "<nop>", opts)

-- more useful escape
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- move focus
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- buffers
keymap("n", "<leader>bn", ":bn<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bn", ":bp<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>sv", ":vsp<CR>", { desc = "Split right" })
keymap("n", "<leader>sh", ":sp<CR>", { desc = "Split down" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- stay in visual mode after shifts
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- copy to system clipboard with ctrl+c
map("v", "<C-c>", '"+y', opts)

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

local builtin = require("telescope.builtin")
keymap("n", "<leader>e", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
keymap("n", "<leader>f", builtin.find_files, opts)
keymap("n", "<leader>g", builtin.live_grep, opts)
keymap("n", "<leader>b", builtin.buffers, opts)
keymap("n", "<leader>h", builtin.help_tags, opts)
