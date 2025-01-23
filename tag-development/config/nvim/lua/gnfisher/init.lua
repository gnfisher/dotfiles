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

vim.g.netrw_banner = 0

vim.cmd([[
  cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]])
