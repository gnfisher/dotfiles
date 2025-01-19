return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  keys = {
    { "<C-p>",           "<cmd>Telescope git_files<cr>",                 desc = "Find File" },
    { "<leader>fh",      "<cmd>Telescope help_tags<cr>",                 desc = "Help Tags" },
    { "<leader>fg",      "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep" },
    { "<leader>fd",      "<cmd>Telescope diagnostics<cr>",               desc = "Diagnostics" },
    { "<leader>/",       "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Find in Buffer" },
    { "<leader>gw",      "<cmd>Telescope grep_string<cr>",               desc = "Grep Word" },
    { "<leader><space>", "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim"
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

    vim.defer_fn(function()
      require("telescope").load_extension("ui-select")
    end, 100)
  end
}
