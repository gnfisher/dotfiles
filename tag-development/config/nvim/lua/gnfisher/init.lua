vim.g.mapleader = " "

require("gnfisher.set")
require("gnfisher.lazy_init")
require("gnfisher.keymaps")

require("gnfisher.functions.close_help_window")
require("gnfisher.functions.highlight_yank")
require("gnfisher.functions.jump_to_last_line")
require("gnfisher.functions.toggle_bg")
require("gnfisher.functions.trim_whitespace")

vim.g.netrw_banner = 0

vim.cmd([[
  cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]])

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local gnfGroup = augroup('gnf', {})

autocmd('LspAttach', {
    group = gnfGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.document_symbol() end, opts)
        vim.keymap.set("n", "<leader>lS", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>brn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
})
