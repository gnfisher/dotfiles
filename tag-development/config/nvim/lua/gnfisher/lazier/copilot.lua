return {
  "github/copilot.vim",
  config = function()
    vim.cmd(":Copilot disable")
    vim.keymap.set("i", "<C-j>", "<Plug>(copilot-suggest)")
    vim.keymap.set("i", "<C-k>", "<Plug>(copilot-next)")
  end
}
