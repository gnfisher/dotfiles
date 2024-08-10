local actions = require "telescope.actions"
local builtin = require('telescope.builtin')

pcall(require("telescope").load_extension, "ui-select")

require("telescope").setup({
  mappings = {
    i = {
      ["<C-x>"] = actions.delete_buffer + actions.move_to_top,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  }
})

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>ft", builtin.git_files)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find)

vim.keymap.set("n", "<leader>gw", builtin.grep_string)

vim.keymap.set("n", "<leader><space>", builtin.buffers)
