return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-plenary",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest.go"),
          require("neotest.minitest"),
        }
      })

      vim.keymap.set("n", "<leader>tc", function()
        neotest.run.run()
      end)
      vim.keymap.set("n", "<leader>tC", function()
        neotest.run.run(vim.fn.expand("%"))
      end)
    end,
  },
}
