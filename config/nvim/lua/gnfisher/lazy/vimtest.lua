return {
  'vim-test/vim-test',
  config = function()
    vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>ts', ':TestSuite<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>', { silent = true })

    vim.g["test#strategy"] = "vtr"
    vim.g["test#go#gotest#options"] = "-v"
  end
}
