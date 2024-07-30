return {
  'projekt0n/github-nvim-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  -- priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    vim.cmd('colorscheme github_dark_dimmed')
    local function ToggleBg()
      if vim.o.background == "dark" then
        vim.o.background = "light"
        vim.cmd("colorscheme github_light")
      else
        vim.o.background = "dark"
        -- vim.cmd("colorscheme habamax")
        vim.cmd("colorscheme github_dark_dimmed")
      end
    end

    vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })
  end,
}
