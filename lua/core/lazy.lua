local M = {}

function M.setup()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

  local core = require("core")
  local plugin_specs = {}

  -- LSP config
  if core.plugin_groups.lsp then
    table.insert(plugin_specs, { import = "plugins.lsp" })
  end

  -- Git
  if core.plugin_groups.git then
    table.insert(plugin_specs, { import = "plugins.git" })
  end

  -- Basic
  if core.plugin_groups.basic then
    table.insert(plugin_specs, { import = "plugins.basic" })
  end

  -- Statusline
  if core.plugin_groups.statusline then
    table.insert(plugin_specs, { import = "plugins.statusline" })
  end

  -- Colorscheme
  if core.plugin_groups.ui.colorscheme then
    table.insert(plugin_specs, { import = "plugins.colorschemes." .. core.plugin_groups.ui.install })
  end

  -- Cmp
  if core.plugin_groups.cmp then
    table.insert(plugin_specs, { import = "plugins.cmp" })
  end

  -- Blink
  if core.plugin_groups.blink then
    table.insert(plugin_specs, { import = "plugins.blink" })
  end

  -- Sicissors
  if core.plugin_groups.scissors then
    table.insert(plugin_specs, { import = "plugins.scissors" })
  end

  if core.plugin_groups.treesitter then
    table.insert(plugin_specs, { import = "plugins.treesitter" })
  end

  if core.plugin_groups.nvimtree then
    table.insert(plugin_specs, { import = "plugins.nvimtree" })
  end

  if core.plugin_groups.telescope then
    table.insert(plugin_specs, { import = "plugins.telescope" })
    table.insert(plugin_specs, { import = "plugins.telescope.harpoon" })
  end

  if core.plugin_groups.flash then
    table.insert(plugin_specs, { import = "plugins.flash" })
  end

  if core.plugin_groups.bqf then
    table.insert(plugin_specs, { import = "plugins.bqf" })
  end

  if core.plugin_groups.trouble then
    table.insert(plugin_specs, { import = "plugins.trouble" })
  end

  if core.plugin_groups.cursor then
    table.insert(plugin_specs, { import = "plugins.cursor" })
  end
  
  if core.plugin_groups.rest then
    table.insert(plugin_specs, { import = "plugins.rest" })
  end

  -- Mini
  table.insert(plugin_specs, {
    "echasnovski/mini.nvim",
    name = "mini",
    version = "*",
    event = "VeryLazy",
    init = function()
      package.preload["nvim-web-devicons"] = function()
        package.loaded["nvim-web-devicons"] = {}
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    config = function()
      -- mini: core
      if core.plugin_groups.mini.core then
        require("plugins.mini.align").setup()
        require("plugins.mini.bracketed").setup()
        require("plugins.mini.clue").setup()
        require("plugins.mini.comment").setup()
        require("plugins.mini.hipatterns").setup()
        require("plugins.mini.move").setup()
        require("plugins.mini.operators").setup()
        require("plugins.mini.pairs").setup()
        require("plugins.mini.splitjoin").setup()
        require("plugins.mini.bufremove").setup()
      end
      -- mini: ui
      if core.plugin_groups.mini.ui then
        -- require("plugins.mini.colors").setup()
        require("plugins.mini.icons").setup()
      end
      -- mini: indentscope
      if core.plugin_groups.mini.indentscope then
        require("plugins.mini.indentscope").setup()
      end
      -- mini: animate
      if core.plugin_groups.mini.animation then
        require("plugins.mini.animate").setup()
      end
      if not core.plugin_groups.flash then
        -- mini: move
        if core.plugin_groups.mini.move then
          require("plugins.mini.jump").setup()
          require("plugins.mini.jump2d").setup()
        end
      end
      -- mini: pick
      if core.plugin_groups.mini.pick then
        require("plugins.mini.pick").setup()
      end
      -- mini: notify
      if core.plugin_groups.mini.notify then
        require("plugins.mini.notify").setup()
      end
      -- mini: files
      if core.plugin_groups.mini.files then
        require("plugins.mini.files").setup()
      end
      if core.plugin_groups.mini.ai_move then
        require("plugins.mini.ai").setup()
        require("plugins.mini.surround").setup()
      end
      if core.plugin_groups.mini.extra then
        require("plugins.mini.extra").setup()
      end
    end
  })

  require("lazy").setup(plugin_specs, {
    install = { colorscheme = {} },
    checker = { enabled = true, notify = false },
    change_detection = { notify = true },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        }
      }
    }
  })
end

-- cde abc
return M
