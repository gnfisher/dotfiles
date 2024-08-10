return {
  'tjdevries/colorbuddy.nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000,
  config = function()
    local function SetDark()
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbuddy")
    end

    local function ToggleBg()
      if vim.o.background == "dark" then
        vim.o.background = "light"
        vim.cmd.colorscheme("morning")
      else
        SetDark()
      end
    end

    SetDark()
    vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })
  end,
}
