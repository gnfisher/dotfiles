return {
  'projekt0n/github-nvim-theme',
  -- 'akiicat/vim-github-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  -- priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require("github-theme").setup({
      options = {
        hide_end_of_buffer = false,
        dim_inactive = true,
        styles = {
          comments = "italic",
          functions = "bold",
        },
      },
    })

    -- vim.cmd('colorscheme github_dark_dimmed')
    local function ToggleBg()
      if vim.o.background == "dark" then
        vim.o.background = "light"
        -- vim.cmd("colorscheme github_light")
      else
        vim.o.background = "dark"
        -- vim.cmd("colorscheme github_dark_dimmed")
      end
    end

    vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })
  end,
}
