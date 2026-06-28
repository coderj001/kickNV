-- Suppress treesitter-related errors early
-- This must be set up before any plugins load
do
  local original_err_writeln = vim.api.nvim_err_writeln
  vim.api.nvim_err_writeln = function(msg)
    if type(msg) == 'string' then
      -- Suppress noice.nvim treesitter query errors
      if msg:match 'substitute' and msg:match 'Query error' then
        return
      end
      -- Suppress textobjects initialization errors (temporary, until treesitter loads)
      if msg:match 'nvim-treesitter-textobjects' and msg:match 'Failed to source' then
        return
      end
    end
    return original_err_writeln(msg)
  end

  -- Also suppress via vim.notify if used
  local original_notify = vim.notify
  vim.notify = function(msg, level, opts)
    if type(msg) == 'string' then
      if msg:match 'substitute' and msg:match 'Query error' then
        return
      end
      if msg:match 'nvim-treesitter-textobjects' and msg:match 'Failed to source' then
        return
      end
    end
    return original_notify(msg, level, opts)
  end
end

if vim.g.vscode then
  require 'code.vscode'
else
  require('core').setup()
end
