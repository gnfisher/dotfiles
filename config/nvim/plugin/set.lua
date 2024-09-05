vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

vim.opt.number = true
-- vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.backspace = '2'

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.clipboard = 'unnamedplus'
require('base.rdm')

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.list = false

vim.opt.mouse = 'a'
vim.opt.mousefocus = true

vim.opt.virtualedit = 'block'

vim.o.scroll = 10
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'

vim.opt.termguicolors = true

-- vim.opt.colorcolumn = "101"
vim.opt.fillchars = { eob = "~" }
vim.opt.fillchars:append("vert:|")
vim.opt.cursorline = false

vim.opt.updatetime = 50

vim.opt.belloff = 'all'
vim.opt.visualbell = true
vim.opt.errorbells = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.completeopt = 'menuone,noinsert,noselect'

vim.o.wildmenu = true
vim.o.wildmode = "longest:list"

vim.opt.showmatch = false
