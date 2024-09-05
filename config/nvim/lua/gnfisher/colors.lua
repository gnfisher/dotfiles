local function SetDark()
  vim.o.background = "dark"
  vim.cmd.colorscheme("gruvbuddy")
end

function ToggleBg()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd.colorscheme("delek")
  else
    SetDark()
  end
end

vim.o.background = "light"
vim.cmd.colorscheme("delek")
vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })

vim.cmd('highlight clear MatchParen')
vim.cmd('highlight clear TSPunctBracket')
