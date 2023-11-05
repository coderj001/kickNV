local M = {}
local status, lastplace = pcall(require, "nvim-lastplace")

function M.setup()
  if (not status) then return end

  lastplace.setup({
    lastplace_ignore_buftype = {
      "quickfix",
      "nofile",
      "help",
    },
    lastplace_ignore_filetype = {
      "gitcommit",
      "gitrebase",
      "svn",
      "hgcommit",
    },
    lastplace_open_folds = true,
  })
end

return M
