local M = {}

function M.setup()
  require("mason-tool-installer").setup({
    ensure_installed = {
      "lua-language-server",
      "typescript-language-server",
    },
    auto_update = true,
    run_on_start = true,
    start_delay = 0,     -- 3 second delay
    debounce_hours = 24, -- at least 24 hours between attempts to install/update
  })
  vim.cmd("MasonToolsUpdate")
end

return M
