return {
  {
    'ishan9299/nvim-solarized-lua',
  },
  {
    "wtfox/jellybeans.nvim",
    priority = 1000,
    config = function()
      require("jellybeans").setup()
    end,
  }
}
