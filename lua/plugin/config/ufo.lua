local M = {}

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix      = ('  %d '):format(endLnum - lnum)
  local lines       = ('[%d lines] '):format(endLnum - lnum)
  local sufWidth    = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth    = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  table.insert(virtText, { suffix, 'Comment' })
  table.insert(virtText, { lines, 'Todo' })
  return newVirtText
end


function M.setup()
  require('ufo').setup({
    fold_virt_text_handler = handler,
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end,
    preview = {
      win_config = {
        border       = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
        winblend     = 0,
        winhighlight = "Normal:LazyNormal",
      }
    }
  })
end

return M