vim.g.mapleader = " "

require("gnfisher.set")
require("gnfisher.lazy_init")
require("gnfisher.keymaps")

require("gnfisher.functions.close_help_window")
require("gnfisher.functions.highlight_yank")
require("gnfisher.functions.jump_to_last_line")
require("gnfisher.functions.toggle_bg")
require("gnfisher.functions.trim_whitespace")
require("gnfisher.functions.gitsh")

pcall(vim.cmd, "colorscheme grb-lucius")
pcall(vim.cmd, "GrbLuciusDarkHighContrast")
-- require('gnfisher.modern-lucius').setup({
--   style = 'dark',         -- or 'light'
--   contrast = 'high',      -- or 'low'/'high'
--   contrast_bg = 'normal', -- or 'high'
--   bold = true,
--   underline = true,
--   transparent = false,
-- })

vim.g.netrw_banner = 0

-- Set up diagnostic config early
vim.diagnostic.config({
  signs = false,
  virtual_text = false,
  underline = true,
  float = false,
  severity_sort = true,
  update_in_insert = false
})

-- Expand %% to current buffer's directory
vim.cmd([[
  cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]])
