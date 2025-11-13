----------------------
--- BASIC SETTINGS ---
----------------------
vim.o.equalalways = false -- Don't resize windows when splitting
vim.opt.compatible = false -- Disable Vi compatibility, allows for more advanced Vim features
vim.opt.backspace = { "indent", "eol", "start" } -- Make backspace work more intuitively
vim.opt.history = 1000 -- Increase command history to 1000 lines
vim.opt.ruler = true -- Show the cursor position all the time
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.modifiable = true
vim.opt.showcmd = true -- Show incomplete commands in the bottom right
vim.opt.wildmenu = true -- Enable command-line completion in a menu
vim.opt.wildmode = { "list", "longest" } -- Complete the longest common string
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })
vim.opt.diffopt:append("linematch:60")
vim.opt.encoding = "utf-8" -- Use UTF-8 encoding for files
--vim.opt.fileencoding = 'utf-8'         -- Use UTF-8 for the file you're editing
vim.opt.autoread = true -- Auto-reload files when changed externally
vim.opt.backup = false -- Don't keep a backup file after saving
vim.opt.writebackup = false -- Don't keep a backup file while saving
vim.opt.swapfile = false -- Disable swap files
vim.opt.undofile = true -- Enable undo history files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Directory for undo files
vim.opt.hidden = true -- Allow switching buffers without saving
vim.opt.scrolloff = 6 -- Start scrolling 8 lines before reaching the edge of the viewport
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible to the left and right of the cursor
vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed
vim.opt.smartcase = true -- Override ignorecase if search pattern contains uppercase letters

----------------------
--- USER INTERFACE ---
----------------------
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.cursorline = true -- Highlight the current line
vim.opt.showmatch = true -- Show matching brackets/parentheses
vim.opt.matchtime = 1 -- Highlight matching brackets/parentheses for 2/10th of a second
vim.opt.breakindent = true
vim.opt.list = false -- Show invisible characters (tabs, spaces, etc.)
vim.opt.listchars = { tab = "»·", trail = "·", extends = "→", precedes = "←" } -- Set symbols for invisible characters
vim.opt.linebreak = true -- Break lines at word boundaries when wrapping
vim.opt.wrap = false -- Disable linewrap
vim.opt.showbreak = "↪\\" -- Show an arrow where lines break
vim.opt.signcolumn = "yes" -- Always show the sign column (used by plugins like GitGutter)
vim.opt.colorcolumn = "100" -- Highlight column 80 (good for code style)
vim.opt.cmdheight = 1 -- Set the command bar height to 2 lines
vim.opt.laststatus = 2 -- Always show the status line
vim.opt.splitbelow = true -- Horizontal splits open below the current window
vim.opt.splitright = true -- Vertical splits open to the right of the current window
vim.opt.foldmethod = syntax -- Use treesitter fold method
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folding
vim.opt.foldenable = true -- Enable folds
vim.opt.foldlevelstart = 9 -- Start 3 folds deep
vim.opt.foldopen = ""
vim.opt.foldopen:remove("search")
vim.opt.wildignore:append({ "*.o", "*.obj", "*.bin", "*.dll", "*.exe" }) -- Ignore common binary files during tab completion
vim.cmd("syntax on") -- Enable syntax highlighting
-- vim.cmd('colorscheme desert')          -- Set the colorscheme to 'desert'
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = nc
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300

--------------------------
--- TABS & INDENTATION ---
--------------------------
vim.opt.tabstop = 4 -- Number of spaces a <Tab> in the file counts for
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4 -- Number of spaces in tab when editing
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.smartindent = true -- Automatically inserts one extra level of indentation in some cases
vim.opt.shiftround = true -- Round indent to a multiple of 'shiftwidth'

-----------------
--- SEARCHING ---
-----------------

vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override ignorecase if search pattern contains uppercase letters
vim.opt.incsearch = true -- Show matches as you type
vim.opt.hlsearch = true -- Highlight search results
vim.opt.gdefault = true -- Apply global substitutions by default
vim.opt.wrapscan = true -- Wrap searches around the end of the file

------------------------
--- MOUSE & KEYBOARD ---
------------------------

vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.timeoutlen = 500 -- Time in milliseconds to wait for a mapped sequence to complete
vim.opt.ttimeoutlen = 0 -- Time in milliseconds to wait for key code sequences
-- vim.opt.keymodel = {'startsel', 'stopsel'} -- Use Shift and Ctrl to select text
-- vim.opt.clipboard = 'unnamed'      -- Use the system clipboard for copy/paste
-- vim.opt.whichwrap:append {'<', '>', 'h', 'l'} -- Allow left/right arrows to wrap to the previous/next line
vim.opt.wildignorecase = true -- Ignore case when completing file names and directories

------------------
--- COMPLETION ---
------------------

vim.opt.completeopt = { "menuone", "noselect" } -- Customize insert mode completion
vim.opt.pumheight = 10 -- Limit completion menu height
vim.opt.pumblend = 10 -- Make the popup menu transparent
vim.opt.shortmess:append("c") -- Avoid showing the completion message
vim.opt.spelllang = "en_us" -- Set spell check language to US English
vim.opt.spellsuggest = { "best", 9 } -- Show best 9 spelling suggestions

------------------
--- STATUSLINE ---
------------------

vim.opt.statusline = "%f %h%m%r %=%-14.(%l,%c%V%) %P" -- Customize statusline: show file name, status, and cursor position
vim.opt.showmode = true -- Show mode (like -- INSERT --) in command line
vim.opt.rulerformat = "%15(%l,%c%V %P%)" -- Show line, column, and percentage in the ruler

-------------------------
--- FILETYPE SETTINGS ---
-------------------------

vim.cmd("filetype plugin on") -- Enable filetype plugins
vim.cmd("filetype indent on") -- Enable filetype-based indenting

---------------------
--- NETRW SETTINGS---
---------------------
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
vim.g.netrw_winsize = 50
vim.g.netrw_keepdir = 0

---------------------
--- MISCELLANEOUS ---
---------------------

vim.opt.lazyredraw = true -- Don't redraw while executing macros
vim.opt.updatetime = 50 -- Faster completion (4000ms default)
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.termguicolors = true -- Enable 24-bit RGB colors in the TUI
vim.opt.background = "dark" -- Set background color to dark
vim.opt.errorbells = false -- Disable error bells
vim.opt.visualbell = true -- Use visual bell instead of beeping
vim.opt.virtualedit = "block" -- Allow cursor to move anywhere in visual block mode
vim.opt.inccommand = "split" -- Show live preview of :s commands
