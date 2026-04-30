local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set marks using leader + shift + number
map("n", "<leader>!", "mA", opts)
map("n", '<leader>"', "mB", opts)
map("n", "<leader>£", "mC", opts)
map("n", "<leader>$", "mD", opts)
map("n", "<leader>%", "mE", opts)
map("n", "<leader>^", "mF", opts)
map("n", "<leader>&", "mG", opts)
map("n", "<leader>*", "mH", opts)
map("n", "<leader>)", "mI", opts)
map("n", "<leader>_", "mJ", opts)

-- Jump to marks using leader + number then jump to recent position
map("n", "<leader>1", [['A`"zz]], opts)
map("n", "<leader>2", [['B`"zz]], opts)
map("n", "<leader>3", [['C`"zz]], opts)
map("n", "<leader>4", [['D`"zz]], opts)
map("n", "<leader>5", [['E`"zz]], opts)
map("n", "<leader>6", [['F`"zz]], opts)
map("n", "<leader>7", [['G`"zz]], opts)
map("n", "<leader>8", [['H`"zz]], opts)
map("n", "<leader>9", [['I`"zz]], opts)
map("n", "<leader>0", [['J`"zz]], opts)

-- less jumpy navigation
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '>-2<CR>gv=gv", opts)
keymap("n", "J", " mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
-- keymap("n", "{", "{zz", opts)
-- keymap("n", "}", "}zz", opts)

-- paste and delete to void register
keymap("x", "<leader>p", '"_dP', opts)
keymap("n", "<leader>d", '"_d', opts)
keymap("v", "<leader>d", '"_d', opts)

-- jump to next/previous diagnostic
keymap("n", "<leader>j", "<cmd>lnext<CR>zz", opts)
keymap("n", "<leader>k", "<cmd>lprev<CR>zz", opts)

-- unbind some keys
-- keymap("n", "Q", "<Nop>", opts)
keymap("n", "<C-q>", "<Nop>", opts)
keymap("n", "q:", "<Nop>", opts)
keymap("n", "q/", "<Nop>", opts)

-- more useful escape
keymap("n", "<Esc>", "<cmd>nohlsearch | set laststatus=0<CR>", opts)
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
keymap("n", "k", "gk")
keymap("n", "j", "gj")

-- stay in visual mode after shifts
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- copy to system clipboard with ctrl+c
map("v", "<C-c>", '"+y', opts)

-- buffers
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
