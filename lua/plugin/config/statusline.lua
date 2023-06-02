local M = {}

function M.setup()
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

  require("lualine").setup({
    options = {
      theme = "tokyonight",
      section_separators = "",
      component_separators = "",
    },
    sections = {
      lualine_a = { { "mode", color = { gui = "bold" } } },
      lualine_b = { "branch", "diff" },
      lualine_c = { { "filename", file_status = true, path = 1, formatter = filename } },
      lualine_x = { "encoding", "fileformat", "filetype", get_words },
      lualine_y = { "progress" },
      lualine_z = { lsp_status, { "diagnostics", sources = { "nvim_lsp" } } },
    },
    extensions = {
      "fzf",
      "fugitive",
      "quickfix",
      "nvim-tree",
    },
  })
end

return M
