local set = vim.keymap.set

-- Space is leader so make it a noop
set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- One less key to press
set('n', '<Leader>;', ':', { silent = true })

-- Don't accidentally jump to Ex mode
set("n", "Q", "<nop>")

-- Reload vim config (in dotfiles)
set("n", "<Leader>so", function()
  vim.cmd("so")
end)

-- Better copy paste
set("n", "cp", '"+y', { silent = true })
set("n", "cv", '"+p', { silent = true })
set("n", "cV", '"+P', { silent = true })
set("v", "cp", '"+y', { silent = true })
set("v", "cv", '"+p', { silent = true })
set("v", "cV", '"+P', { silent = true })

-- Toggle background
set("n", "<F6>", ":ToggleBg<CR>")


-- Escape
--

-- Make C-c identical to escape
set("i", "<C-c>", "<Esc>")

-- Map terminal escape to escape
set("t", "<Esc>", "<C-\\><C-n>")


-- Close windows
--

-- Close the current buffer
set("n", "<C-x>b", vim.cmd.bd)

-- Close the quickfix window
set("n", "<C-x>c", "<cmd>cclose<CR>")

-- Close the location list window
set("n", "<C-x>l", "<cmd>lclose<CR>")

-- Close the preview window
set("n", "<C-x>p", "<cmd>pclose<CR>")

-- Close the help window
set("n", "<C-x>h", ":CloseHelp<CR>", { noremap = true, silent = true, desc = "Close help window" })


-- Navigation
--

-- Ctrl + direction moves between panes
set('n', '<C-h>', '<C-w>h')
set('n', '<C-j>', '<C-w>j')
set('n', '<C-k>', '<C-w>k')
set('n', '<C-l>', '<C-w>l')

-- Resize panes
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

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

-- Quickfix
set("n", "<leader>n", ":cnext<cr>zz")
set("n", "<leader>p", ":cprevious<cr>zz")
set("n", "<leader>o", ":copen<cr>zz")
set("n", "<leader>c", ":cclose<cr>zz")

-- Tabs
set("n", "<C-t>", ":<C-u>tabnew<cr>")
set("n", "<Tab>", ":<C-u>tabnext<cr>")
set("n", "<S-Tab>", ":<C-u>tabprev<cr>")


-- Diagnostics
--

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

-- Place all dignostics into a qflist
set("n", "<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })


-- Git
--

set('n', '<leader>gg', ':Gitsh<CR>', { noremap = true, silent = true })
set('n', '<leader>gt', ':Gitsigns toggle_signs<CR>', { noremap = true, silent = true })

set('n', '-', ':Ex<cr>')
