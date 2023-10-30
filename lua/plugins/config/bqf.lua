local M = {}
local status, bqf = pcall(require, "bqf")

function M.setup()
  if (not status) then return end

  bqf.setup {
    auto_resize_height = false,
    preview = {
      auto_preview = false,
    },
  }
end

return M
