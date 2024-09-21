return {
  {
    'tjdevries/colorbuddy.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
  },
  { 'projekt0n/github-nvim-theme' },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require('solarized').setup(opts)
    end,
  },
  {
    'rose-pine/neovim',
    lazy = false,
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        styles = {
          italic = false,
        },
      })
      require("gnfisher.colors")
    end
  }
}
