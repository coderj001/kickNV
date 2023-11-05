local M = {}

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

function M.setup()
  require("lualine").setup({
    options = {
      theme = require("config.defaults").config.colorscheme,
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
      refresh = {
        statusline = 100,
      },
    },
    sections = {
      lualine_a = {
        { "fancy_mode", width = 3 }
      },
      lualine_b = {
        { "fancy_branch" },
        { "fancy_diff" },
        { "fancy_lsp_servers" },
        { "fancy_diagnostics" },
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
        { "fancy_cwd", substitute_home = true }
      },
      lualine_y = {
        { "fancy_filetype", ts_icon = "" },
        get_words,
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },
        { "fancy_searchcount" },
        { "fancy_macro" },
        { "fancy_location" },
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
