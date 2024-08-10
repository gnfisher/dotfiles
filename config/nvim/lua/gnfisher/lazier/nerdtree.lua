return {
  -- "nvim-tree/nvim-tree.lua",
  -- config = function()
  --   vim.g.loaded_netrw = 1
  --   vim.g.loaded_netrwPlugin = 1
  --   require("nvim-tree").setup({
  --     renderer = {
  --       indent_markers = {
  --         enable = true,
  --       },
  --       icons = {
  --         glyphs = {
  --           folder = {
  --             arrow_closed = ">",
  --             arrow_open = "v",
  --           },
  --         },
  --         show = {
  --           file = false,
  --           folder = false,
  --           folder_arrow = true,
  --           git = false,
  --         },
  --       },
  --     },
  --   })

  --   vim.keymap.set("n", "<Leader>nt", ":NvimTreeToggle<CR>", { silent = true })
  --   vim.keymap.set("n", "<Leader>nf", ":NvimTreeFocus<CR>", { silent = true })
  --   vim.keymap.set("n", "<Leader>nF", ":NvimTreeFindFile<CR>", { silent = true })
  -- end
  -- 'preservim/nerdtree',
  -- lazy = false,
  -- config = function()
  --   vim.keymap.set("n", "<Leader>nt", ":NERDTreeToggle<CR>", { silent = true })
  --   vim.keymap.set("n", "<Leader>nf", ":NERDTreeFocus<CR>", { silent = true })
  --   vim.keymap.set("n", "<Leader>nF", ":NERDTreeFind<CR>", { silent = true })

  --   local augroup = vim.api.nvim_create_augroup
  --   local autocmd = vim.api.nvim_create_autocmd

  --   local nerdtree_group = augroup("NERDTree", {})

  --   autocmd("VimEnter", {
  --     group = nerdtree_group,
  --     callback = function()
  --       vim.cmd("NERDTree")
  --       vim.cmd("wincmd p")
  --     end
  --   })

  --   autocmd("BufEnter", {
  --     group = nerdtree_group,
  --     callback = function()
  --       if vim.fn.winnr() == vim.fn.winnr('h')
  --           and vim.fn.bufname('#'):match('NERD_tree_%d+')
  --           and not vim.fn.bufname('%'):match('NERD_tree_%d+')
  --           and vim.fn.winnr('$') > 1 then
  --         local buf = vim.fn.bufnr()
  --         vim.cmd('buffer #')
  --         vim.cmd('wincmd w')
  --         vim.cmd('buffer ' .. buf)
  --       end
  --     end
  --   })
  -- end,
}
