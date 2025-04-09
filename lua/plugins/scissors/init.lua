return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets/scissors/",
    },
    keys = {
      {
        "<leader>se",
        mode = { "n" },
        function() require("scissors").editSnippet() end,
        desc = "Snippet: Edit"
      },
      {
        "<leader>sa",
        mode = { "n", "x" },
        function() require("scissors").addNewSnippet() end,
        desc = "Snippet: Add"
      },
    }
  }
}
