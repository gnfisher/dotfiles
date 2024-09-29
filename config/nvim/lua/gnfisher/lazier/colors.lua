local function SetColor(color)
  color = color or "tokyonight-storm"
  vim.cmd.colorscheme(color)
end

return {
  {
    'miikanissi/modus-themes.nvim',
    lazy = false,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {},
    config = function()
      -- SetColor("tokyonight-storm")
    end
  },
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    config = function()
      require('github-theme').setup({
        styles = {           -- Style to be applied to different syntax groups
          comments = 'NONE', -- Value is any valid attr-list value `:help attr-list`
          functions = 'bold',
          keywords = 'NONE',
          variables = 'NONE',
          conditionals = 'NONE',
          constants = 'NONE',
          numbers = 'NONE',
          operators = 'NONE',
          strings = 'NONE',
          types = 'bold',
        },
      })
    end,
  },
  {
    'catppuccin/nvim',
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        background = {         -- :h background
          light = "latte",
          dark = "macchiato",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
        term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = true,               -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15,            -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,              -- Force no italic
        no_bold = false,                -- Force no bold
        no_underline = false,           -- Force no underline
        styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" },      -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      -- setup must be called before loading
      SetColor("catppuccin")
    end
  }
}
