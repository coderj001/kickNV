local M = {}

function M.setup()
  require('treesj').setup({
    notify = true,
    dot_repeat = false,
    max_join_length = 500,
    use_default_keymaps = false,
  })
end

return M
