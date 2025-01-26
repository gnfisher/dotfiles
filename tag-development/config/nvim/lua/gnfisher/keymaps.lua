local set = vim.keymap.set

vim.g.mapleader = " "

set("n", "<Leader>so", function()
  vim.cmd("so")
end)

set('n', '-', ':Ex<cr>')

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("n", "Q", "<nop>")
set("n", "<leader>=", vim.lsp.buf.format)

set("n", "<C-k>", "<cmd>cnext<CR>zz")
set("n", "<C-j>", "<cmd>cprev<CR>zz")
set("n", "<leader>k", "<cmd>lnext<CR>zz")
set("n", "<leader>j", "<cmd>lprev<CR>zz")

set("n", "cp", '"+y', { silent = true })
set("n", "cv", '"+p', { silent = true })
set("n", "cV", '"+P', { silent = true })
set("v", "cp", '"+y', { silent = true })
set("v", "cv", '"+p', { silent = true })
set("v", "cV", '"+P', { silent = true })

set("n", "<F6>", ":ToggleBg<CR>")

set("i", "<C-c>", "<Esc>")
set("t", "<Esc>", "<C-\\><C-n>")
set("n", "<C-x>b", vim.cmd.bd)
set("n", "<C-x>q", "<cmd>cclose<CR>")
set("n", "<C-x>l", "<cmd>lclose<CR>")
set("n", "<C-x>p", "<cmd>pclose<CR>")
set("n", "<C-x>h", ":CloseHelp<CR>", { noremap = true, silent = true, desc = "Close help window" })

set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

set("n", "]d", function()
  vim.diagnostic.goto_next({})
  vim.api.nvim_feedkeys("zz", "n", false)
end)

set("n", "[d", function()
  vim.diagnostic.goto_prev({})
  vim.api.nvim_feedkeys("zz", "n", false)
end)

set("n", "<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
