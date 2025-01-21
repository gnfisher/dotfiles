vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

vim.opt.cmdheight = 2
vim.opt.number = false
vim.opt.relativenumber = false
vim.api.nvim_set_option('textwidth', 80)

vim.opt.showtabline = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.backspace = '2'

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = false

vim.opt.clipboard = 'unnamedplus'

-- In codespaces if rdm is present use it for clipboard.
-- See https://github.com/BlakeWilliams/remote-development-manager
if vim.fn.executable('rdm') == 1 and os.getenv("CODESPACES") ~= nil then
  vim.g.clipboard = {
    name = "rdm",
    copy = {
      ["+"] = { "rdm", "copy" },
      ["*"] = { "rdm", "copy" }
    },
    paste = {
      ["+"] = { "rdm", "paste" },
      ["*"] = { "rdm", "paste" }
    },
  }
end

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.list = false

vim.opt.mouse = 'a'
vim.opt.mousefocus = true

vim.opt.virtualedit = 'block'

vim.o.scroll = 10
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'no'

vim.opt.termguicolors = true

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
