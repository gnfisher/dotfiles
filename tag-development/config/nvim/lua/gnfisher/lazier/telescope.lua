return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  keys = {
    { "<leader>;",  ":<C-u>Telescope git_files<cr>",                desc = "Find Git File" },
    { "<leader>ff", ":<C-u>Telescope find_files<cr>",               desc = "Find File" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
    { "<leader>d",  "<cmd>Telescope diagnostics<cr>",               desc = "Diagnostics" },
    { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Find in Buffer" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>",               desc = "Grep Word" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Help Tags" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "gnfisher/nvim-telescope-ctags-plus",
  },
  config = function()
    local actions = require "telescope.actions"

    require("telescope").setup({
      mappings = {
        i = {
          ["<C-x>"] = actions.delete_buffer + actions.move_to_top,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        }
      },
    })
    require("telescope").load_extension("ctags_plus")

    vim.defer_fn(function()
      require("telescope").load_extension("ui-select")
    end, 100)
  end
}
