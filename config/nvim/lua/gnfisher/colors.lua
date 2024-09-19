local function SetDark()
  vim.o.background = "dark"
end

function ToggleBg()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    SetDark()
  end
end

vim.cmd.colorscheme("default")
vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })
