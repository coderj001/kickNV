return {
  "stevearc/quicker.nvim",
  config = function()
    local status, quicker = pcall(require, "quicker")
    if (not status) then return end
    quicker.setup({
      opts = {
        buflisted = false,
        number = true,
        relativenumber = false,
        signcolumn = "auto",
        winfixheight = true,
        wrap = false,
      },
      keys = {
        {
          "<leader>q",
          mode = { "n" },
          function()
            require("quicker").toggle()
          end,
          desc = "Toggle quickfix"
        },
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    })
  end
}
