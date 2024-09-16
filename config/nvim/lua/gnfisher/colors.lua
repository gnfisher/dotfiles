local function SetDark()
  vim.o.background = "dark"
  vim.cmd.colorscheme("solarized")
end

function ToggleBg()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd.colorscheme("solarized")
  else
    SetDark()
  end
end

vim.cmd.colorscheme("solarized")
vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })
