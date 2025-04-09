if true then
  return {
    "folke/trouble.nvim",
    opts = {
      use_dignostic_signs = true,
      action_keys = {
        close = { "q", "<esc>" },
        cancle = { "<c-e>" },
      }
    },
    cmd = {
      "TroubleToggle",
      "Trouble"
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    }
  }
else
  return {}
end
