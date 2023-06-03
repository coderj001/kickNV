local M = {}

function M.setup()
  require("rest-nvim").setup({
    result_split_horizontal = false,
    highlight = { enabled = true, timeout = 150 },
    result = {
      show_url = true,
      show_http_info = true,
      show_headers = true,
      formatters = {
        json = "jq",
        html = function(body)
          return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
        end
      }
    },
    jump_to_request = true,
  })
  local rest_nvim = require('rest-nvim')
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "http",
    callback = function()
      local buff = tonumber(vim.fn.expand("<abuf>"), 10)
      vim.keymap.set("n", "<leader>rn", rest_nvim.run,
        { noremap = true, buffer = buff })
      vim.keymap.set("n", "<leader>rl", rest_nvim.last,
        { noremap = true, buffer = buff })
      vim.keymap.set("n", "<leader>rp", function() rest_nvim.run(true) end,
        { noremap = true, buffer = buff })
    end
  })
end

return M
