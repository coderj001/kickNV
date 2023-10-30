-- File Syntax
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "p00f/nvim-ts-rainbow",
      "HiPhish/nvim-ts-rainbow2",
      "windwp/nvim-ts-autotag",
      "mizlan/iswap.nvim",
      {
        "m-demare/hlargs.nvim",
        config = function()
          require("hlargs").setup()
        end
      },
      {
        "ZhiyuanLck/smart-pairs",
        event = "InsertEnter",
        config = function()
          require("pairs"):setup()
        end
      }
    },
    build = function()
      pcall(require("nvim-treesitter.install").update { with_sync = false })
    end,
    config = function()
      require("plugins.extras.treesitter").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      })
    end,
    dependencies = {
      "nvim-ts-context-commentstring",
      "JoosepAlviste/nvim-ts-context-commentstring"
    }
  },                  -- "gc" to comment visual regions/lines
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  {                   -- braket and tag
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.extras.autopair").setup()
    end
  },
}
