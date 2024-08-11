return {
  "github/copilot.vim",
  config = function()
    vim.cmd(":Copilot disable")
    vim.keymap.set("i", "<C-j>", "<Plug>(copilot-suggest)")
    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)")
    vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)")
  end
}
