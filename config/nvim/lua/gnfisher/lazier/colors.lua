return {
  {
    'tjdevries/colorbuddy.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
      require("gnfisher.colors")
    end
  },
  { 'projekt0n/github-nvim-theme' },
  { 'Mofiqul/dracula.nvim' },
}
