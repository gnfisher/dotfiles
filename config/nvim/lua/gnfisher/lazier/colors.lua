local function SetColor(color)
  color = color or "tokyonight-storm"
  vim.cmd.colorscheme(color)
end

return {
  {
    'miikanissi/modus-themes.nvim',
    lazy = false,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {},
    config = function()
      SetColor("tokyonight-storm")
    end
  },
}
