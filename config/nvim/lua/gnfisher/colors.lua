local function SetDark()
  vim.o.background = "dark"
  vim.cmd.colorscheme("gruvbuddy")
end

function ToggleBg()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd.colorscheme("zellner")
  else
    SetDark()
  end
end

vim.cmd.colorscheme("gruvbuddy")
vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })

vim.cmd('highlight clear MatchParen')
vim.cmd('highlight clear TSPunctBracket')
