function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
end

local function toggle_bg()
  if vim.opt.background:get() == 'dark' then
    vim.opt.background = 'light'
    ColorMyPencils()
  else
    vim.opt.background = 'dark'
    ColorMyPencils()
  end
end

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      vim.api.nvim_set_keymap('n', '<F6>', '<cmd>lua toggle_bg()<CR>', { noremap = true, silent = true })

      require('rose-pine').setup({
        -- disable_background = true,
        styles = {
          italic = false,
        },
      })

      vim.cmd("colorscheme rose-pine")

      ColorMyPencils()
    end
  },


}
