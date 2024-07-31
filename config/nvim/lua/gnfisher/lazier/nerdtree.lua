return {
  'preservim/nerdtree',
  config = function()
    vim.keymap.set("n", "<Leader>nt", ":NERDTreeToggle<CR>", { silent = true })
    vim.keymap.set("n", "<Leader>nf", ":NERDTreeFocus<CR>", { silent = true })
    vim.keymap.set("n", "<Leader>nF", ":NERDTreeFind<CR>", { silent = true })

    -- local augroup = vim.api.nvim_create_augroup
    -- local autocmd = vim.api.nvim_create_autocmd

    -- local nerdtree_group = augroup("NERDTree", {})
  end
}
