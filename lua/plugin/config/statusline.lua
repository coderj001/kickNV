local M = {}
local ui = require("core.default_config").ui

local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function get_words()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  else
    return ""
  end
end

local function filename()
  local file = vim.fn.expand("%:p")
  local homedir = vim.loop.os_homedir()
  local base_dir = homedir .. "/projects"
  local _, index = string.find(file, base_dir, 1, true)
  if index then
    return vim.fn.fnamemodify(file, ":~:.")
  else
    return vim.fn.expand("%:t")
  end
end

local function lsp_status()
  local lsp = vim.lsp.util.get_diagnostics_count(0, [[Error]])
  local icon = ''
  if lsp > 0 then
    icon = ' '
  end
  return icon .. 'LSP'
end

function M.setup()
  require("lualine").setup({
    options = {
      theme = ui.theme,
      section_separators = "",
      component_separators = "",
    },
    sections = {
      lualine_a = {
        {
          "mode",
          color = {
            gui = "bold",
          },
        },
      },
      lualine_b = {
        "branch",
        "diff",
        lsp_status,
        {
          "diagnostics",
          sources = {
            "nvim_lsp",
          },
        },
      },
      lualine_c = {
        {
          "filename",
          file_status = true,
          path = 1,
          formatter = filename,
          symbols = {
            modified = '  ',
            readonly = '  ',
            unnamed = '  ',
            newfile = '  ',
          },
        },
      },
      lualine_x = {
        search_result
      },
      lualine_y = {
        "filetype",
        -- "encoding",
        -- "fileformat",
        get_words,
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },
        {
          "location",
          color = { fg = "#ff9e64" },
        }
      },
      lualine_z = { "progress" },
    },
    inactive_sections = {
      lualine_c = { '%f %y %m' },
      lualine_x = {},
    },
    extensions = {
      "fzf",
      "fugitive",
      "quickfix",
      "nvim-tree",
      "man",
      "lazy"
    },
  })
end

return M
