---@mod galaxyline Galaxy Line configuration
---@brief [[
--- Configuration for the galaxyline status line plugin.
--- Provides a highly customized status line with git integration,
--- LSP diagnostics, and file information.
---@brief ]]

local gl = require("galaxyline")
local diagnostic = require("galaxyline.provider_diagnostic")

-- { == Helper Functions ==> ================================================== 
---@section Helper functions and utilities
--- This section contains utility functions and conditions used throughout the statusline
--- configuration. These include conditions for checking window width, filetype existence,
--- and other helper functions.

local conditions = {
  gl = require("galaxyline.condition"),
  has_file_type = function()
    if not vim.bo.filetype or vim.bo.filetype == "" then return false end
    return true
  end,
  ---@param win_width? number
  break_width = function(win_width)
    win_width = win_width or 50
    if vim.fn.winwidth(0) / 2 > win_width then return true end
    return false
  end,
}

-- Format icons for different file formats
local format_icons = { dos = "", mac = "", unix = "" }

-- Map of special buffer types to their display names
local BufferTypeMap = {
  ["alpha"] = "󰍂 Alpha",
  ["Mundo"] = "Mundo History",
  ["MundoDiff"] = "Mundo Diff",
  ["NvimTree"] = " Tree",
  ["neo-tree"] = " Tree",
  ["fugitive"] = " Fugitive",
  ["fugitiveblame"] = " Fugitive Blame",
  ["help"] = "󰋗 Help",
  ["minimap"] = "Minimap",
  ["qf"] = "󰁨 Quick Fix",
  ["tabman"] = "Tab Manager",
  ["tagbar"] = "Tagbar",
  ["FTerm"] = "Terminal",
  ["neoterm"] = " NeoTerm",
  ["toggleterm"] = " ToggleTerm",
  ["git"] = " Git",
  ["NeogitStatus"] = " Neogit Status",
  ["NeogitPopup"] = " Neogit Popup",
  ["NeogitCommitMessage"] = "󰍣 Neogit Commit",
  ["DiffviewFiles"] = " Diff View",
  ["dapui_scopes"] = "󱁯 Dap Scope",
  ["dapui_breakpoints"] = " Dap Breakpoints",
  ["dapui_stacks"] = " Dap Stacks",
  ["dapui_watches"] = "󰙔 Dap Watch",
  ["dap-repl"] = " Dap REPL",
  ["Outline"] = " SymbolOutline",
  ["fern"] = " Fern FM",
  ["filetree"] = " Tree",
}

-- We run into some issues with tint. Toggling it off/on apparently fixes them
local function pseudo_toggle_tint()
  local tint_ok, tint = pcall(require, "tint")
  if tint_ok then
    tint.toggle()
    tint.toggle()
  end
end

-- { == Theme Configuration ==> ==============================================
---@section Theme configuration
--- This section handles theme-specific color configurations.
--- It detects the current colorscheme and sets appropriate colors for the statusline.
--- Currently supports default, tokyonight and catppuccin-mocha themes.

local colors = require("galaxyline.theme").default

if vim.g.colors_name == "tokyonight" then
  local palette = require("tokyonight.colors").setup()
  colors = {
    fg = palette.fg_dark,
    bg = palette.bg_highlight,
    darkblue = palette.bg_dark,
    cyan = palette.cyan,
    green = palette.green,
    yellow = palette.blue,
    orange = palette.orange,
    violet = palette.purple,
    magenta = palette.magenta,
    blue = palette.blue,
    red = palette.red,
  }
end

if vim.g.colors_name == "catppuccin-mocha" then
  local palette = require("catppuccin.palettes.mocha")
  colors = {
    fg = palette.text,
    bg = palette.base,
    darkblue = palette.mantle,
    cyan = palette.overlay0,
    green = palette.green,
    yellow = palette.lavender,
    orange = palette.flamingo,
    violet = palette.lavender,
    magenta = palette.mauve,
    blue = palette.mantle,
    red = palette.red,
  }
end
-- <== }

-- { == Component Sections ==> =============================================

gl.section.left = {
  -- Mode ----------------------------------------------------------------------
  {
    ModeStartSep = {
      provider = function() end,
      -- separator = " ",
      separator = " ",
      separator_highlight = { colors.darkblue, colors.bg },
    },
  },
  {
    ViMode = {
      icon = function()
        local icons = {
          n = "󰆾 ",
          i = " ",
          c = "󰞷 ",
          v = "󰆿 ",
          V = "󰆿 ",
          [""] = "󰆿 ",
          C = "󰞷 ",
          R = "󰛔 ",
          t = " ",
        }
        return icons[vim.fn.mode()]
      end,
      provider = function()
        -- auto change color according the vim mode
        local alias = {
          n = "N ",
          i = "I ",
          c = "C ",
          V = "VL",
          [""] = "VB",
          v = "V ",
          C = "C ",
          ["r?"] = ":CONFIRM",
          rm = "--MORE",
          R = "R ",
          Rv = "RV",
          s = "S ",
          S = "S ",
          ["r"] = "HIT-ENTER",
          [""] = "SELECT",
          t = "T ",
          ["!"] = "SH",
        }
        local mode_color = {
          n = colors.cyan,
          i = colors.red,
          v = colors.yellow,
          [""] = colors.yellow,
          V = colors.yellow,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange,
          ic = colors.yellow,
          R = colors.blue,
          Rv = colors.blue,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red,
        }
        local vim_mode = vim.fn.mode()
        vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim_mode])
        return alias[vim_mode]
      end,
      highlight = { colors.darkblue, colors.bg },
      separator = " ",
      separator_highlight = { colors.darkblue, colors.bg },
    },
  },
  {
    ModeEndSep = {
      provider = function() end,
      separator = "",
      separator_highlight = { colors.bg },
    },
  },

  -- Git -----------------------------------------------------------------------
  {
    GitStartSep = {
      provider = function() end,
      separator = " ",
      separator_highlight = { colors.darkblue },
    },
  },
  {
    GitIcon = {
      provider = function() return "  " end,
      condition = conditions.gl.check_git_workspace,
      highlight = { colors.orange, colors.darkblue },
    },
  },
  {
    GitBranch = {
      provider = "GitBranch",
      highlight = { colors.fg, colors.darkblue },
      condition = conditions.gl.check_git_workspace,
      separator = " ",
      separator_highlight = { colors.darkblue, colors.darkblue },
    },
  },
  {
    DiffAdd = {
      provider = "DiffAdd",
      icon = " ",
      condition = conditions.break_width,
      highlight = { colors.green, colors.darkblue },
    },
  },
  {
    DiffModified = {
      provider = "DiffModified",
      icon = "  ",
      condition = conditions.break_width,
      highlight = { colors.orange, colors.darkblue },
    },
  },
  {
    DiffRemove = {
      provider = "DiffRemove",
      icon = "  ",
      condition = conditions.break_width,
      highlight = { colors.red, colors.darkblue },
    },
  },
  {
    DiffEndSep = {
      provider = function() end,
      separator = "",
      separator_highlight = { colors.bg, colors.darkblue },
    },
  },
  {
    Space = {
      provider = function() return " " end,
      highlight = { colors.bg, colors.bg },
    },
  },

  -- File ----------------------------------------------------------------------
  {
    FileIcon = {
      provider = "FileIcon",
      condition = function()
        if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then return true end
        return false
      end,
      highlight = {
        require("galaxyline.provider_fileinfo").get_file_icon_color,
        colors.bg,
      },
    },
  },
  {
    BufferType = {
      -- provider = "FilePath",
      provider = "FileName",
      condition = conditions.has_file_type,
      highlight = { colors.fg, colors.bg },
    },
  },

  -- Diagnostics ---------------------------------------------------------------
  {
    DiagnosticError = {
      provider = diagnostic.get_diagnostic_error,
      icon = "  ",
      highlight = { colors.red, colors.bg },
    },
  },
  {
    DiagnosticWarn = {
      provider = diagnostic.get_diagnostic_warn,
      condition = function() return conditions.break_width(55) end,
      icon = "  ",
      highlight = { colors.yellow, colors.bg },
    },
  },
  {
    DiagnosticInfo = {
      provider = diagnostic.get_diagnostic_info,
      condition = function() return conditions.break_width(55) end,
      highlight = { colors.green, colors.bg },
      icon = "  ",
    },
  },
  {
    DiagnosticHint = {
      provider = diagnostic.get_diagnostic_hint,
      condition = function() return conditions.break_width(55) end,
      highlight = { colors.violet, colors.bg },
      icon = " 󰌵 ",
    },
  },
  {
    DarkSepara = {
      provider = function() return "" end,
      highlight = { colors.bg },
    },
  },
}

gl.section.right = {
  -- LSP Client ----------------------------------------------------------------
  {
    LspStartSep = {
      provider = function() return "     " end,
      highlight = { colors.yellow, colors.bg },
      separator = "",
      separator_highlight = { colors.bg },
    },
  },
  {
    GetLspClient = {
      provider = "GetLspClient",
      condition = function() return conditions.break_width(35) end,
      highlight = { colors.fg, colors.bg },
    },
  },
  {
    LspEndSep = {
      provider = function() return "" end,
      highlight = { colors.bg, colors.darkblue },
      separator = " ",
      separator_highlight = { colors.bg, colors.bg },
    },
  },

  -- Position ------------------------------------------------------------------
  {
    LineInfo = {
      provider = "LineColumn",
      condition = conditions.break_width,
      highlight = { colors.fg, colors.darkblue },
      separator = "   ",
      separator_highlight = { colors.yellow, colors.darkblue },
    },
  },
  {
    ScrollBar = {
      provider = "ScrollBar",
      highlight = { colors.violet, colors.darkblue },
      separator = " ",
      separator_highlight = { colors.blue, colors.darkblue },
    },
  },
  {
    Percent = {
      provider = "LinePercent",
      highlight = { colors.fg, colors.darkblue },
      separator = " ", -- " ", --     󰞁 󰆌
      separator_highlight = { colors.blue, colors.darkblue },
    },
  },

  -- Indentation ---------------------------------------------------------------
  {
    Indentation = {
      provider = function()
        local indentation_type = "Tabs:"
        if vim.api.nvim_buf_get_option(0, "expandtab") then indentation_type = " Spaces:" end
        return indentation_type .. vim.o.ts
      end,
      condition = conditions.break_width,
      highlight = { colors.fg, colors.darkblue },
      separator = "  ",
      separator_highlight = { colors.yellow, colors.darkblue },
    },
  },

  -- File Format ---------------------------------------------------------------
  {
    FileFormat = {
      provider = function()
        local fileFormat = string.upper(vim.bo.fileencoding)
        return fileFormat
      end,
      condition = function() return conditions.break_width(55) end,
      highlight = { colors.fg, colors.darkblue },
      -- separator = " ",
      separator = "  " .. format_icons[vim.bo.fileformat] .. " ",
      separator_highlight = { colors.yellow, colors.darkblue },
    },
  },

  {
    RightSpace = {
      provider = function() return " " end,
      highlight = { colors.darkblue, colors.darkblue },
    },
  },
}

gl.section.short_line_left = {
  {
    ShortLineBlankSpace = {
      provider = function() return " " end,
      highlight = { colors.bg, colors.bg },
    },
  },
  {
    ShortLineLeftBufferName = {
      provider = "FileName",
      condition = function()
        if BufferTypeMap[vim.bo.filetype] then return false end
        return true
      end,
      highlight = { colors.fg, colors.bg },
    },
  },
  {
    ShortLineLeftBufferType = {
      provider = function()
        -- local file_name = vim.fn.expand("%:t")
        if vim.bo.filetype == "neo-tree" then return " 󰙅 Neo-tree " end
        local mapped_name = BufferTypeMap[vim.bo.filetype]
        if mapped_name then return " " .. mapped_name .. " " end
      end,
      condition = conditions.has_file_type,
      highlight = { colors.fg, colors.bg },
      separator = " ",
      separator_highlight = { colors.bg, colors.darkblue },
    },
  },
  {
    ShortLineLeftWindowNumber = {
      provider = function() return vim.api.nvim_win_get_number(vim.api.nvim_get_current_win()) .. " " end,
      icon = " ",
      highlight = { colors.blue, colors.darkblue },
      separator = "",
      separator_highlight = { colors.darkblue, "colors.black" },
    },
  },
}

-- { == Setup ==> ========================================================
---@section Setup and initialization
--- Initializes the statusline configuration including special buffers list,
--- autogroup creation, and component initialization.

gl.short_line_list = {
  "alpha",
  "LuaTree",
  "vista",
  "dbui",
  "startify",
  "term",
  "nerdtree",
  "fugitive",
  "fugitiveblame",
  "plug",
  "NvimTree",
  "neo-tree",
  "DiffviewFiles",
  "Outline",
  "neoterm",
  "fern",
  "toggleterm",
  "filetree",
  "explorer",
}

gl.galaxyline_augroup()

-- Initialize components
pseudo_toggle_tint()
local timer = vim.loop.new_timer()

return gl
