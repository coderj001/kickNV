if false then
  return {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    opts = {},
    keys = {
      {
        "<leader>q",
        function()
            require("quicker").toggle()
        end,
        mode = "",
        desc = "Toggle quickfix",
      }
    },
  }
else
  return {}
end
