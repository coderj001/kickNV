return {
  "NTBBloodbath/rest.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  ft = "http",
  keys = {
    { "<leader>rn", function() require("rest-nvim").run() end,     desc = "Run request" },
    { "<leader>rl", function() require("rest-nvim").last() end,    desc = "Run request last" },
    { "<leader>rp", function() require("rest-nvim").run(true) end, desc = "Run request last" },
  },
  config = function()
    local status, restnv = pcall(require, "rest-nvim")
    if (not status) then
      vim.notify("error loading rest.nvim")
      return
    end
    restnv.setup({
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
  end
}
