return {
  "nvim-cmp",
  event = { "BufEnter", "BufRead" },
  dependencies = {
    {
      "Exafunction/codeium.nvim",
      cmd = "Codeium",
      build = ":Codeium Auth",
      opts = {},
    },
  },
}
