return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
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
  end
}
