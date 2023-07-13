set encoding=utf-8

let mapleader = " "

" Reload your nvim config
map <leader>s :so ~/.config/nvim/init.vim<CR>

set nocompatible
set termguicolors
set list listchars=tab:▸\ ,trail:·,nbsp:·
set mouse=a
set belloff=all
set expandtab
set backspace=2   " Backspace deletes like most programs in insert mode
set tabstop=2 softtabstop=2 shiftwidth=2 " Default tab size
set nobackup
set nowritebackup
set noswapfile
set history=100
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=1000
set undoreload=10000
set cursorline
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set hlsearch      " highlight the current search term
set laststatus=10  " Always display the status line
set autowrite     " Automatically :write before running commands
set autoread      " If a file is changed outside of vim automatically reload it without asking
set modelines=0   " Disable modelines as a security precaution
set nomodeline
set number
set relativenumber
set ruler
set colorcolumn=120
set signcolumn=number
set hidden
set showtabline=2 " Always show tabline
set ignorecase smartcase
set cmdheight=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set scrolloff=3
set wildmode=longest,list
set wildmenu
set nojoinspaces
set splitright
set splitbelow
set foldmethod=manual
set nofoldenable
set completeopt=menu,menuone,noselect
set spellfile=$HOME/.vim-spell-en.utf-8.add
set complete=.,w,b,u,t,i
set complete+=kspell
set path+=**
set diffopt+=vertical
set shortmess=c                " Try not showing any messages
set tags=./tags;./.tags;$HOME  " Look for .tags in all directories, like .git

filetype plugin indent on

augroup base
  autocmd!

  autocmd BufNewFile,BufRead *.ru setfiletype ruby
  autocmd BufNewFile,BufRead *.css.erb setfiletype css
  autocmd BufNewFile,BufRead *.mkd,*.md,*.markdown setfiletype markdown
  autocmd BufNewFile,BufRead *.json setfiletype javascript

  autocmd Filetype markdown setlocal spell textwidth=80
  autocmd Filetype gitcommit setlocal spell textwidth=76 colorcolumn=77

  autocmd TermOpen * startinsert  " switch to insert mode when entering term

  autocmd BufWritePre * lua require('base.helpers').trim_whitespace()
  autocmd BufReadPost * lua require('base.helpers').jump_to_last_line()
augroup END

call plug#begin()
  " Our lord and savior
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-eunuch'
  Plug 'RRethy/nvim-treesitter-endwise'

  " Appearance
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'j-hui/fidget.nvim'

  " Telescope
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim'

  " Plugins for LSP and completions
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'onsails/lspkind.nvim'
  Plug 'mfussenegger/nvim-lint'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'

  " Other
  Plug 'github/copilot.vim'
  Plug 'vim-test/vim-test'

  " Add your own plugins by creating a bundles.vim file.
  if filereadable(expand("~/.config/nvim/bundles.vim"))
      source ~/.config/nvim/bundles.vim
  endif
call plug#end()

" If we aren't using lsp, then do things the old way.
set omnifunc=syntaxcomplete#Complete

" Use ripgrep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
nmap \ :Rg<SPACE>
nmap K :grep "\b<C-R><C-W>\b"<CR>:cw<CR>:redraw!<CR>

" Telescope
lua quickview = require('telescope.themes').get_dropdown({ previewer = false})
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers(quickview)<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').loclist()<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').tags(dropdown)<cr>
nnoremap <leader>gi <cmd>lua require('telescope').extensions.gh.issues()<cr>
nnoremap <leader>gp <cmd>lua require('telescope').extensions.gh.pull_request()<cr>

" Lua snip expansion
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

lua require('base.telescope')
lua require('base.treesitter')
lua require('base.completion')
lua require('base.lsp')
lua require('base.lint')
lua require('base.rdm')
lua require('fidget').setup{}
lua require('lualine').setup({ options = { theme = 'auto' }})

" Add your custom configuration in a custom.vim file.
if filereadable(expand("~/.config/nvim/custom.vim"))
    source ~/.config/nvim/custom.vim
endif
