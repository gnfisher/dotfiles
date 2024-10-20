local set = vim.keymap.set

-- Space is leader so make it a noop
set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- One less key to press
set('n', '<Leader>;', ':', { silent = true })

-- Don't accidentally jump to Ex mode
set("n", "Q", "<nop>")

-- Better copy paste
set("n", "cp", '"+y', { silent = true })
set("n", "cv", '"+p', { silent = true })
set("n", "cV", '"+P', { silent = true })
set("v", "cp", '"+y', { silent = true })
set("v", "cv", '"+p', { silent = true })
set("v", "cV", '"+P', { silent = true })

-- Toggle background
set("n", "<F6>", ":ToggleBg<CR>")

-- Make C-c identical to escape
set("i", "<C-c>", "<Esc>")


-- Map terminal escape to escape
set("t", "<Esc>", "<C-\\><C-n>")

-- Close the current buffer
set("n", "<C-x>b", vim.cmd.bd)

-- Close the preview window
set("n", "<C-x>p", "<cmd>pclose<CR>")

-- Close the help window
set("n", "<C-x>h", ":CloseHelp<CR>", { noremap = true, silent = true, desc = "Close help window" })


-- Navigation

-- nnoremap ,e :e **/*<C-z><S-Tab
set('n', ",e", ":e **/*<C-z><S-Tab>")

-- Ctrl + direction moves between panes
set('n', '<C-h>', '<C-w>h')
set('n', '<C-j>', '<C-w>j')
set('n', '<C-k>', '<C-w>k')
set('n', '<C-l>', '<C-w>l')

-- Center while navigating
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "{", "{zz")
set("n", "}", "}zz")
set("n", "N", "Nzz")
set("n", "n", "nzz")
set("n", "G", "Gzz")
set("n", "gg", "ggzz")
set("n", "gd", "gdzz")
set("n", "<C-i>", "<C-i>zz")
set("n", "<C-o>", "<C-o>zz")
set("n", "%", "%zz")
set("n", "*", "*zz")
set("n", "#", "#zz")

-- More natural k/j
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Navigate to next qflist item
set("n", "]q", ":cnext<cr>zz")

-- Navigate to previos qflist item
set("n", "[q", ":cprevious<cr>zz")


-- Diagnostics
--

-- Place all dignostics into a qflist
set("n", "<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })

-- Goto next diagnostic of any severity
set("n", "]d", function()
  vim.diagnostic.goto_next({})
  vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous diagnostic of any severity
set("n", "[d", function()
  vim.diagnostic.goto_prev({})
  vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto next error diagnostic
set("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous error diagnostic
set("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end)
