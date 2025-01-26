return {
  'echasnovski/mini.nvim',
  version = false,
  config = function ()
    require('mini.pick').setup()
    local pick = require('mini.pick')
    vim.keymap.set('n', '<leader>ff', pick.builtin.files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fb', pick.builtin.buffers, { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>fg', pick.builtin.grep_live, { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fh', pick.builtin.help, { desc = 'Search help' })
    vim.keymap.set('n', '<leader>fr', pick.builtin.resume, { desc = 'Resume last picker' })

    require('mini.files').setup()
    vim.keymap.set('n', '<leader>e', ':e.<cr>')
  end
}
