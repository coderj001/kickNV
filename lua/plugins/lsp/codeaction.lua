if true then
  return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },

    },
    event = "LspAttach",
    opts = {},
    keys = {
      {
        "<leader>ca",
        mode = { "n" },
        function() require("tiny-code-action").code_action() end,
        desc = "[c]ode [a]ction",
      },
    }
  }
end
