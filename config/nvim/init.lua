vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local in_codespace = os.getenv("CODESPACES") ~= nil


-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Our lord and savior
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-vinegar',
  'tpope/vim-eunuch',
  'tpope/vim-commentary',
  'tpope/vim-surround',
  'tpope/vim-rails',

  -- Mr. Toomey
  'christoomey/vim-tmux-runner',

  -- DAP for GO
  {
    'mfussenegger/nvim-dap',
    config = function()
      vim.keymap.set('n', '<leader>dc', ':lua require"dap".continue()<CR>')
      vim.keymap.set('n', '<leader>dt', ':lua require"dap-go".debug_test()<CR>')
      vim.keymap.set('n', '<leader>do', ':lua require"dap".step_out()<CR>')
      vim.keymap.set('n', '<leader>di', ':lua require"dap".step_into()<CR>')
      vim.keymap.set('n', '<leader>du', ':lua require"dap".step_over()<CR>')

      vim.keymap.set('n', '<leader>db', ':lua require"dap".toggle_breakpoint()<CR>')

      vim.keymap.set('n', '<leader>dr', ':lua require"dap".repl.toggle()<CR>')

      vim.keymap.set('n', '<leader>dl', ':lua require"dap".run_last()<CR>')
      vim.keymap.set('n', '<leader>dd', ':lua require"dap".disconnect()<CR>')
    end
  },
  {
    'leoluz/nvim-dap-go',
    config = function()
      require('dap-go').setup()
    end
  },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'nvim-telescope/telescope-dap.nvim' },
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()
    end
  },

  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_assume_mapped = true
      -- vim.api.nvim_set_keymap('i', '<C-J>', [[v:lua.require'copilot'.Accept("<CR>")]], { noremap = true, expr = true })
      -- vim.g.copilot_no_tab_map = true
    end
  },

  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      local api = require "nvim-tree.api"
      -- disable netrw at the very start of your init.lua
      -- vim.g.loaded_netrw = 1
      -- vim.g.loaded_netrwPlugin = 1

      vim.keymap.set('n', '<leader>nf', ':NvimTreeFindFile<CR>')
      vim.keymap.set('n', '<leader>nt', api.tree.toggle)
      vim.keymap.set('n', '<leader>nn', api.tree.focus)

      -- OR setup with some options
      require("nvim-tree").setup({
        auto_reload_on_write = true,
        hijack_unnamed_buffer_when_opening = true,
        prefer_startup_root = true,
        sort_by = "case_sensitive",
        actions = {
          open_file = {
            quit_on_open = true
          }
        },
        view = {
          width = 30,
          preserve_window_proportions = true,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds buffer comletion
      'hrsh7th/cmp-buffer',

      -- Adds path completion
      'hrsh7th/cmp-path',

      -- Adds cmdline completion
      'hrsh7th/cmp-cmdline',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',

      -- A tiny plugin that adds vscode-like pictograms to neovim built-in lsp
      'onsails/lspkind.nvim',
    },
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    'projekt0n/github-nvim-theme',
    config = function()
      vim.cmd.colorscheme 'github_dark'
      vim.o.background = 'dark'
    end
  },
  { 'RRethy/nvim-base16' },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'gruvbox'
      -- vim.o.background = 'dark'
    end
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',

      --  Adds end for ruby methods, etc.
      'RRethy/nvim-treesitter-endwise',
    },
    build = ':TSUpdate',
  },

  -- Testing is good
  {
    'vim-test/vim-test',
    config = function()
      vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>ta', ':TestSuite<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>', { silent = true })

      vim.g["test#strategy"] = "vtr"
      vim.g["test#go#gotest#options"] = "-v"
    end
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = true end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = true,
      insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Move to previous/next
      map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
      -- Re-order to previous/next
      map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
      map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
      -- Goto buffer in position...
      map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
      map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
      map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
      map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
      map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
      -- Pin/unpin buffer
      map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
      -- Close buffer
      map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight
      -- Magic buffer-picking mode
      map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
      -- Sort automatically by...
      map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
      map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
      map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
      map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
      map('n', '<Space>ba', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>', opts)
    end,
  },

  -- Installs nvim-metals and sets it up for Scala.
  require 'gnfisher.metals',
}, {})

-- Trim whitespace when you write a buffer.
local function trim_whitespace()
  local save = vim.fn.winsaveview()
  local cmd = 'keeppatterns %s/\\s\\+$//e'
  vim.api.nvim_command(cmd)
  vim.fn.winrestview(save)
end
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = trim_whitespace
})

-- When you open a file jump to the last line you were at.
local function jump_to_last_line()
  local ft = vim.bo.filetype
  local ln = vim.fn.line("'\"")
  local last_line = vim.fn.line("$")
  if ft ~= 'gitcommit' and ln > 0 and ln < last_line then
    vim.api.nvim_command([[:normal g`"]])
  end
end
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = jump_to_last_line
})

-- Toggle background light/dark
function toggle_bg()
  if vim.opt.background:get() == 'dark' then
    vim.opt.background = 'light'
    vim.cmd.colorscheme 'github_light'
  else
    vim.opt.background = 'dark'
    vim.cmd.colorscheme 'github_dark'
  end
end

vim.api.nvim_set_keymap('n', '<F6>', '<cmd>lua toggle_bg()<CR>', { noremap = true, silent = true })

-- Fail in peace.
vim.o.belloff = 'all'
vim.o.visualbell = true
vim.o.errorbells = false

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Listchars
vim.opt.listchars:append({ tab = '› ' })
vim.opt.listchars:append({ eol = '¬' })
vim.opt.list = true

-- Enable mouse mode
vim.o.mouse = 'a'
vim.o.mousefocus = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- If we are in a codespace use rdm to copy
require 'base.rdm'

-- Where am I?
-- vim.o.cursorcolumn = true
vim.o.cursorline = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- But don't backup
vim.o.swapfile = false
vim.o.backup = false

vim.o.showcmd = true

-- "Re" read a buffer if its changed
vim.o.autoread = true

-- Write a buffer when you move away from it
vim.o.autowrite = true
vim.o.hidden = true

vim.o.virtualedit = 'block'

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Some more room for the cmd dispaly
vim.o.cmdheight = 2

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

vim.o.wildmenu = true
vim.o.wildmode = "longest:list"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.scrolloff = 5

-- What happened to the days of 80?
vim.opt.textwidth = 120
vim.opt.colorcolumn = "121"

-- Give me old school borders
vim.opt.fillchars:append("vert:█")

vim.opt.expandtab = true
vim.opt.backspace = '2'
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better copy and paste
vim.keymap.set('n', 'cp', '"+y', { silent = true })
vim.keymap.set('n', 'cv', '"+p', { silent = true })
vim.keymap.set('n', 'cV', '"+P', { silent = true })
vim.keymap.set('v', 'cp', '"+y', { silent = true })
vim.keymap.set('v', 'cv', '"+p', { silent = true })
vim.keymap.set('v', 'cV', '"+P', { silent = true })

-- Convenience
vim.keymap.set('n', '<Leader>;', ':', { silent = true })
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Better quickfix window toggle
vim.keymap.set({ 'n', 'v' }, '<C-j>', ':cnext<CR>')
vim.keymap.set({ 'n', 'v' }, '<C-k>', ':cprev<CR>')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"
require('telescope').setup {
  defaults = {
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    multi_icon = "<>",
    winblend = 0,
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
      prompt_position = "top",

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    color_devicons = true,

    mappings = {
      i = {
        ["<RightMouse>"] = actions.close,
        ["<LeftMouse>"] = actions.select_default,
        ["<ScrollWheelDown>"] = actions.move_selection_next,
        ["<ScrollWheelUp>"] = actions.move_selection_previous,

        ["<C-x>"] = false,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-n>"] = "move_selection_next",

        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,

        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,

        ["<C-w>"] = function()
          vim.api.nvim_input "<c-s-w>"
        end,
      },

      n = {
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    "bash",
    "diff",
    "dockerfile",
    "elixir",
    "elm",
    "fish",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "go",
    "graphql",
    "html",
    "javascript",
    "json",
    "lua",
    "proto",
    "python",
    "ruby",
    "rust",
    "scala",
    "scss",
    "sql",
    "typescript",
    "vim",
    "vimdoc",
    "yaml"
  },
  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
    endwise = {
      enabled = true
    },
  },
}

-- Setup erb parser for treesitter
local parser_configs = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_configs.erb = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-embedded-template", -- local path or git repo
    files = { "src/parser.c" },
    -- optional entries:
    branch = "master",                      -- default branch in case of git repo if different from master
    generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "html.erb",                    -- if filetype does not match the parser name
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<M-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format { async = false }
    end
  })
end

local eslint_on_attach = function(n, bufnr)
  -- Setup eslint autocommand
  if vim.fn.executable('vscode-eslint-language-server') == 1 then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end
  on_attach(n, bufnr)
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
--
-- Can't use this yet, rubocop old
-- local rubocop = in_codespace and { cmd = { "/workspaces/github/bin/rubocop", "--lsp" } } or {}

local servers = {
  jsonls = {},
  eslint = {},
  gopls = { cmd = "gopls" },
  golangci_lint_ls = {},
  elmls = {},
  tsserver = {},
  sorbet = { cmd = { "srb", "tc", "--lsp" } },
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        if server_name == "eslint" then
          eslint_on_attach(client, bufnr)
        else
          on_attach(client, bufnr)
        end
      end,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}
lspkind.init()

cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'path' },
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol_text',
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      }
    }
  },
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
    }),
  }
}

-- Also borders for dagnostics and hover
-- vim.diagnostic.config {
--   virtual_text = false,
--   float = {
--     header = true,
--     border = 'rounded',
--     focusable = true,
--   },
-- }

-- require('tabline').setup({
--   show_index = false,         -- show tab index
--   show_modify = true,         -- show buffer modification indicator
--   show_icon = false,          -- show file extension icon
--   fnamemodify = ':.',         -- file name modifier
--   modify_indicator = '[+]',   -- modify indicator
--   no_name = 'No name',        -- no name buffer name
--   brackets = { '[', ']' },    -- file name brackets surrounding
--   inactive_tab_max_length = 0 -- max length of inactive tab titles, 0 to ignore
-- })

-- require("gruvbox").setup({
--   terminal_colors = true, -- add neovim terminal colors
--   undercurl = true,
--   underline = true,
--   bold = true,
--   italic = {
--     strings = true,
--     emphasis = true,
--     comments = true,
--     operators = false,
--     folds = true,
--   },
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = false,
--   invert_intend_guides = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "",  -- can be "hard", "soft" or empty string
--   palette_overrides = {},
--   overrides = {
--     ["LineNr"] = { fg = "#00CFFF" },
--   },
--   dim_inactive = false,
--   transparent_mode = true,
-- })
-- vim.cmd("colorscheme gruvbox")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
