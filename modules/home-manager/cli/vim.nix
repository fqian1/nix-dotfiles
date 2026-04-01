{pkgs, ...}: {
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [

    ];

    settings = {
      number = true;
      relativenumber = true;
      background = "dark";
      # backupdir =
      copyindent = true;
      # directory =
      expandtab = true;
      hidden = true;
      history = 1000;
      ignorecase = true;
      # modeline
      mouse = true;
      shiftwidth = 4;
      smartcase = true;
      tabstop = 4;
#      undodir
      undofile = true;
    };

    extraConfig = ''
      set noequalalways
      set nocompatible
      set backspace=indent,eol,start
      set ruler
      set showcmd
      set selection=exclusive
      set modifiable
      set noautochdir
      set iskeyword+=-
      set path+=**
      set autoread
      set encoding=utf-8
      set wildmenu
      set wildmode=list,longest
      set wildignore+=*.o,*.obj,*.pyc
      set nobackup
      set nowritebackup
      set noswapfile
      set scrolloff=6
      set sidescrolloff=8
      set diffopt+=linematch:60

      " let &undodir = expand('~/.vim/undodir')

      let g:have_nerd_font=1
      set cursorline
      set showmatch
      set matchtime=1
      set breakindent
      set nolist
      set listchars=tab:»·,trail:·,extends:→,precedes:←
      set linebreak
      set nowrap
      set showbreak=↪\\
      set signcolumn=yes
      set cmdheight=1
      set laststatus=0
      set splitbelow
      set splitright
      set foldmethod=indent
      set foldenable
      set foldlevelstart=9
      set foldopen-=search
      set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
      syntax on
      set winblend=0
      set conceallevel=0
      set concealcursor=nc
      set lazyredraw
      set synmaxcol=300

      set softtabstop=4
      set expandtab
      set autoindent
      set smartindent
      set shiftround
      set incsearch
      set hlsearch
      set nogdefault
      set nowrapscan

      set timeoutlen=500
      set ttimeoutlen=0
      " set clipboard=unnamedplus
      set whichwrap=
      set wildignorecase

      set completeopt=menuone,noselect
      set pumheight=10
      set pumblend=10
      set shortmess+=c
      set spelllang=en_us
      set spellsuggest=best,9
      set statusline=%f\ %h%m%r\ %=%-14.(%l,%c%V%)\ %P
      set showmode
      set rulerformat=%15(%l,%c%V\ %P%)
      filetype plugin on
      filetype indent on
      let g:netrw_banner = 0
      let g:netrw_liststyle = 3
      let g:netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
      let g:netrw_winsize = 50
      let g:netrw_keepdir = 0
      set lazyredraw
      set updatetime=50
      set redrawtime=10000
      set maxmempattern=20000
      set noerrorbells
      set visualbell
      set virtualedit=block
      set incsearch
      set inccommand=nosplit

      hi Normal           ctermfg=NONE ctermbg=NONE
      hi NormalFloat      ctermbg=0
      hi FloatBorder      ctermfg=7    ctermbg=0
      hi Cursor           cterm=reverse
      hi CursorLine       ctermbg=0    cterm=NONE
      hi ColorColumn      ctermbg=0
      hi Visual           ctermbg=12
      hi Directory        ctermfg=4
      hi MsgArea          ctermbg=NONE
      hi Cmdline          ctermfg=11   cterm=bold
      hi NonText          ctermfg=8
      hi Folded           ctermfg=7    ctermbg=0
      hi Title            ctermfg=4    cterm=bold
      hi Comment          ctermfg=7    cterm=italic
      hi Constant         ctermfg=11
      hi String           ctermfg=2
      hi Identifier       ctermfg=1
      hi Function         ctermfg=4
      hi Statement        ctermfg=5
      hi PreProc          ctermfg=13
      hi Type             ctermfg=3
      hi Special          ctermfg=6
      hi Underlined       cterm=underline
      hi Error            ctermfg=1    cterm=bold
      hi Todo             ctermfg=0    ctermbg=3    cterm=bold
      hi LineNr           ctermfg=7    ctermbg=NONE
      hi CursorLineNr     ctermfg=11   cterm=bold
      hi SignColumn       ctermbg=NONE
      hi VertSplit        ctermfg=0    ctermbg=NONE
      hi StatusLine       ctermfg=NONE ctermbg=0    cterm=NONE
      hi StatusLineNC     ctermfg=8    ctermbg=NONE
      hi Search           ctermfg=0    ctermbg=3
      hi IncSearch        ctermfg=0    ctermbg=11
      hi MatchParen       ctermfg=15   ctermbg=12   cterm=bold
      hi Pmenu            ctermfg=15   ctermbg=0
      hi PmenuSel         ctermfg=15   ctermbg=12
      hi WildMenu         ctermfg=0    ctermbg=4
      hi DiffAdd          ctermfg=2    ctermbg=NONE
      hi DiffChange       ctermfg=3    ctermbg=NONE
      hi DiffDelete       ctermfg=1    ctermbg=NONE
      hi DiffText         ctermfg=4    ctermbg=0


      " Set marks using leader + shift + number
      nnoremap <leader>! mA
      nnoremap <leader>" mB
      nnoremap <leader>£ mC
      nnoremap <leader>$ mD
      nnoremap <leader>% mE
      nnoremap <leader>^ mF
      nnoremap <leader>& mG
      nnoremap <leader>* mH
      nnoremap <leader>) mI
      nnoremap <leader>_ mJ

      " Jump to marks and center screen
      nnoremap <leader>1 'A`"zz
      nnoremap <leader>2 'B`"zz
      nnoremap <leader>3 'C`"zz
      nnoremap <leader>4 'D`"zz
      nnoremap <leader>5 'E`"zz
      nnoremap <leader>6 'F`"zz
      nnoremap <leader>7 'G`"zz
      nnoremap <leader>8 'H`"zz
      nnoremap <leader>9 'I`"zz
      nnoremap <leader>0 'J`"zz


      " Move visual blocks
      vnoremap J :m '>+1<CR>gv=gv
      vnoremap K :m '<-2<CR>gv=gv

      " Keep cursor in place when joining lines
      nnoremap J mzJ`z

      " Keep cursor centered during scrolling and searching
      nnoremap <C-d> <C-d>zz
      nnoremap <C-u> <C-u>zz
      nnoremap n nzz
      nnoremap N Nzz

      " Paste over selection without losing current register
      xnoremap <leader>p "_dP

      " Delete to void register (black hole)
      nnoremap <leader>d "_d
      vnoremap <leader>d "_d


      " Disable annoying keys
      nnoremap <C-q> <Nop>
      nnoremap q: <Nop>
      nnoremap q/ <Nop>

      " Clear search highlights and hide statusline on Esc
      nnoremap <Esc> :nohlsearch <Bar> set laststatus=0<CR>

      nnoremap <C-h> <C-w>h
      nnoremap <C-l> <C-w>l
      nnoremap <c-k> <c-w>k
      nnoremap <C-j> <C-w>j

      " Stay in visual mode after indenting
      vnoremap < <gv
      vnoremap > >gv

      " Copy to system clipboard
      vnoremap <C-c> "+y


      augroup AutoView
        autocmd!
        autocmd BufWinLeave * silent! mkview
        autocmd BufWinEnter * silent! loadview
      augroup END
    '';
  };
}
