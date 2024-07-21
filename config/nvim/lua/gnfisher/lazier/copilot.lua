return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_assume_mapped = true
    -- vim.api.nvim_set_keymap('i', '<C-J>', [[v:lua.require'copilot'.Accept("<CR>")]], { noremap = true, expr = true })
    -- vim.g.copilot_no_tab_map = true
  end
}
