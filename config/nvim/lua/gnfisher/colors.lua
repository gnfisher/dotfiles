local function SetDark()
  vim.o.background = "dark"
  vim.cmd.colorscheme("kanagawa")
end

function ToggleBg()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd.colorscheme("kanagawa-lotus")
  else
    SetDark()
  end
end

vim.cmd.colorscheme("kanagawa")
vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })

vim.cmd('highlight clear MatchParen')
vim.cmd('highlight clear TSPunctBracket')
