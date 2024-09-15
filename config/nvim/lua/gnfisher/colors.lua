local function SetDark()
  vim.o.background = "dark"
  vim.cmd.colorscheme("dracula")
end

function ToggleBg()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd.colorscheme("github_light")
  else
    SetDark()
  end
end

vim.cmd.colorscheme("dracula")
vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })

vim.cmd('highlight clear MatchParen')
vim.cmd('highlight clear TSPunctBracket')
