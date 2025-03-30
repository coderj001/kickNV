return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- Core mini modules
      if core.plugin_groups.mini.core then
        require("plugins.mini.pairs").setup()
        require("plugins.mini.surround").setup()
        require("plugins.mini.ai").setup()
        require("plugins.mini.indentscope").setup()
        require("plugins.mini.clue").setup()
      end
      
      -- UI modules
      -- require("modules.mini.statusline").setup()
      -- require("modules.mini.tabline").setup()
      -- require("modules.mini.starter").setup()
      
      -- Functionality modules
      -- require("modules.mini.files").setup()
      -- require("modules.mini.comment").setup()
      -- require("modules.mini.hipatterns").setup()
      -- require("modules.mini.bufremove").setup()
      
      -- Coding helpers
      -- require("modules.mini.jump").setup()
      -- require("modules.mini.move").setup()
      -- require("modules.mini.bracketed").setup()
      -- require("modules.mini.trailspace").setup()
    end,
  }
}
