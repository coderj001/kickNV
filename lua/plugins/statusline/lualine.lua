local colors = {
  BG = '#16181b', -- Dark background
  FG = '#c5c4c4', -- Foreground
  YELLOW = '#e8b75f',
  CYAN = '#00bcd4',
  DARKBLUE = '#2b3e50',
  GREEN = '#00e676',
  ORANGE = '#ff7733',
  VIOLET = '#7a3ba8',
  MAGENTA = '#d360aa',
  BLUE = '#4f9cff',
  RED = '#ff3344',
}

-- mode text
local function mode()
  local mode_map = {
    n = 'N',
    i = 'I',
    v = 'V',
    V = 'V',
    [''] = 'VB',
    c = 'C',
    R = 'R',
    t = 'T',
  }
  return mode_map[vim.fn.mode()] or 'UNK'
end

-- buffers
local function buffers_count()
  local bufs = vim.fn.getbufinfo { buflisted = 1 }
  local total = #bufs
  local current = 0
  for i, buf in ipairs(bufs) do
    if buf.bufnr == vim.api.nvim_get_current_buf() then
      current = i
      break
    end
  end
  return string.format('(%d/%d)', current, total)
end

-- LSPs
local function get_lsps()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    return ''
  end
  local names = {}
  for _, c in ipairs(clients) do
    table.insert(names, c.name)
  end
  return '  [' .. table.concat(names, ',') .. ']'
end

-- Search
local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg '/'
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return '/' .. last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

-- Diagnostics (simple icon + count)
local function lsp_status()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

  local parts = {}
  if errors > 0 then
    table.insert(parts, '%#DiffDelete# ' .. errors .. '%*')
  end
  if warns > 0 then
    table.insert(parts, '%#DiffChange# ' .. warns .. '%*')
  end
  if infos > 0 then
    table.insert(parts, '%#DiffAdd# ' .. infos .. '%*')
  end
  if hints > 0 then
    table.insert(parts, '%#DiffChange# ' .. hints .. '%*')
  end

  return table.concat(parts, ' ')
end

-- setup
local function setup()
  require('lualine').setup {
    options = {
      theme = 'auto',
      section_separators = { left = '', right = '' },
      component_separators = '',
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          mode,
          separator = { left = '' },
          right_padding = 2,
          color = { gui = 'bold' },
        },
      },
      lualine_b = {
        { 'branch', icon = '', color = { fg = colors.CYAN, gui = 'bold' } },
        { 'diff', colored = true, symbols = { added = '+', modified = '~', removed = '-' } },
      },
      lualine_c = {
        {
          'filename',
          file_status = true,
          path = 1,
          symbols = { modified = ' ', readonly = ' ', unnamed = '', newfile = '' },
          color = { fg = colors.FG, gui = 'bold' },
        },
      },
      lualine_x = {
        { search_result, color = { fg = colors.RED } },
        { buffers_count, color = { fg = colors.ORANGE, gui = 'bold' } },
      },
      lualine_y = {
        { 'filetype', icon_only = true },
        -- { 'location', color = { fg = colors.YELLOW, gui = 'bold' } },
        { get_lsps },
      },
      lualine_z = {
        {
          'progress',
          separator = { right = '' },
          left_padding = 2,
          color = { fg = colors.BG, bg = colors.VIOLET, gui = 'bold' }
        },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_z = { 'location' },
    },
  }
end

return {
  'nvim-lualine/lualine.nvim',
  name = 'lualine',
  event = 'UIEnter',
  config = setup,
}
