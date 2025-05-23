-- mini.bracketed configuration
local M = {}

function M.setup()
  require('mini.bracketed').setup({
      -- buffer     = { suffix = 'b', options = {} },
      -- comment    = { suffix = 'c', options = {} },
      -- conflict   = { suffix = 'x', options = {} },
      -- diagnostic = { suffix = 'd', options = {} },
      -- file       = { suffix = 'f', options = {} },
      -- indent     = { suffix = 'i', options = {} },
      -- jump       = { suffix = 'j', options = {} },
      -- location   = { suffix = 'l', options = {} },
      -- oldfile    = { suffix = 'o', options = {} },
      -- quickfix   = { suffix = 'q', options = {} },
      -- treesitter = { suffix = 't', options = {} },
      -- undo       = { suffix = 'u', options = {} },
      -- window     = { suffix = 'w', options = {} },
      -- yank       = { suffix = 'y', options = {} },
  })
end

return M

