-- vim.cmd('syntax on')
-- vim.cmd('filetype plugin indent on')

vim.opt.guicursor = ""

vim.opt.mouse = 'a'
vim.opt.mousefocus = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.list = false

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.api.nvim_set_option('textwidth', 80)

vim.opt.number = false
vim.opt.relativenumber = false


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
