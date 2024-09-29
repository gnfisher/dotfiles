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

-- C-d/C-u & n/N reposition cursor in center of screen
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Navigate the quickfix window
set("n", "<Leader>j", "<cmd>cnext<CR>zz")
set("n", "<Leader>k", "<cmd>cprev<CR>zz")

-- More natural k/j
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- Oil
--

-- Toggle oil float view
set("n", "<leader>e", function()
  require("oil").toggle_float()
end)


-- Telescope keybinds
--

set("n", "<leader>ff", require('telescope.builtin').find_files)
set("n", "<leader>ft", require('telescope.builtin').git_files)
set("n", "<leader>fh", require('telescope.builtin').help_tags)
set("n", "<leader>fg", require('telescope.builtin').live_grep)
set("n", "<leader>fd", require('telescope.builtin').diagnostics)
set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find)
set("n", "<leader>gw", require('telescope.builtin').grep_string)
set("n", "<leader><space>", require('telescope.builtin').buffers)


-- Fugitive keybinds
--

set("n", "<Leader>gs", ":ToggleFugitive<CR>", { noremap = true, silent = true })
set("n", "gu", "<cmd>diffget //2<CR>")
set("n", "gh", "<cmd>diffget //3<CR>")
