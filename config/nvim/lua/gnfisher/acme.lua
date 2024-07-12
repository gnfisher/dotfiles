vim.api.nvim_set_hl(0, 'TSCurrentScope', { bg = '#EFFEEC' })

-- Create a namespace for the highlight to avoid conflicts
local namespace_id = vim.api.nvim_create_namespace("CurrentScopeHighlight")

-- Function to highlight the current lexical scope
local ts_utils = require('nvim-treesitter.ts_utils')

function _G.highlight_current_scope()
  local node = ts_utils.get_node_at_cursor()
  if not node then return end

  -- Traverse up the AST to find the appropriate parent node
  local parent = node:parent()
  while parent do
    local type = parent:type()
    if type == 'function' or type == 'function_definition' or type == 'method_definition' or type == 'class' or type == 'if_statement' or type == 'for_statement' or type == 'while_statement' then
      node = parent
      break
    end
    parent = parent:parent()
  end

  -- Get the range of the parent node, including the header or declaration line
  local start_row, start_col, end_row, end_col = node:range()
  vim.api.nvim_buf_clear_namespace(0, namespace_id, 0, -1) -- Clear previous highlights
  -- Highlight the start line
  vim.api.nvim_buf_add_highlight(0, namespace_id, 'TSCurrentScope', start_row, start_col, -1)
  -- Highlight the rest of the lines
  for row = start_row + 1, end_row do
    vim.api.nvim_buf_add_highlight(0, namespace_id, 'TSCurrentScope', row, 0, -1)
  end
end

-- Autocommands to highlight the scope on cursor move
vim.cmd [[
  augroup HighlightScope
    autocmd!
    autocmd CursorMoved * lua highlight_current_scope()
    autocmd CursorMovedI * lua highlight_current_scope()
  augroup END
]]
