vim.opt.guicursor = ''

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.backspace = '2'

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.o.clipboard = 'unnamedplus'

vim.o.hlsearch = false
vim.o.incsearch = true

vim.opt.list = true

vim.o.mouse = 'a'
vim.o.mousefocus = true

vim.opt.virtualedit = 'block'

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'

vim.o.termguicolors = true

vim.opt.colorcolumn = "101"
vim.opt.fillchars:append("vert:█")

vim.opt.updatetime = 50

vim.o.belloff = 'all'
vim.o.visualbell = true
vim.o.errorbells = false
