return {
  'jonathanfilip/vim-lucius',
  -- 'projekt0n/github-nvim-theme',
  -- 'akiicat/vim-github-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  -- priority = 1000, -- make sure to load this before all the other start plugins
  init = function()
    -- require("github-theme").setup({
    --   options = {
    --     hide_end_of_buffer = false,
    --     dim_inactive = true,
    --     styles = {
    --       comments = "italic",
    --       functions = "bold",
    --     },
    --   },
    -- })

    vim.cmd('colorscheme lucius')
    local function ToggleBg()
      if vim.o.background == "dark" then
        vim.o.background = "light"
        vim.g.lucius_style = "light"
        vim.g.lucius_contrast = "high"
        vim.g.lucius_contrast_bg = "normal"
        -- vim.cmd("colorscheme github_light")
      else
        vim.g.lucius_style = "dark"
        vim.g.lucius_contrast = "high"
        vim.g.lucius_contrast_bg = "normal"
        vim.o.background = "dark"
        -- vim.cmd("colorscheme github_dark_dimmed")
      end
    end

    vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })
  end,
}
