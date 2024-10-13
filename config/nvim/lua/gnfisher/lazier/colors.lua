local function SetColor(color)
  color = color or "vim"
  vim.cmd.colorscheme(color)
end

return {
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    config = function()
      require('github-theme').setup({
        styles = {           -- Style to be applied to different syntax groups
          comments = 'NONE', -- Value is any valid attr-list value `:help attr-list`
          functions = 'bold',
          keywords = 'NONE',
          variables = 'NONE',
          conditionals = 'NONE',
          constants = 'NONE',
          numbers = 'NONE',
          operators = 'NONE',
          strings = 'NONE',
          types = 'bold',
        },
      })
    end,
  }
}
