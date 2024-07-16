---@diagnostic disable: unused-function
if vim.g.vscode then
  print("VSCode")
  -- VSCode
  local function split(direction, file)
    if direction == 'h' then
      vim.fn["VSCodeCall"]('workbench.action.splitEditorDown')
    else
      vim.fn["VSCodeCall"]('workbench.action.splitEditorRight')
    end
    if file ~= '' then
      vim.fn["VSCodeExtensionNotify"]('open-file', vim.fn["expand"](file), 'all')
    end
  end

  local function splitNew(direction, file)
    local fileToOpen = file == '' and '__vscode_new__' or file
    split(direction, fileToOpen)
  end

  local function closeOtherEditors()
    vim.fn["VSCodeNotify"]('workbench.action.closeEditorsInOtherGroups')
    vim.fn["VSCodeNotify"]('workbench.action.closeOtherEditors')
  end

  local function manageEditorSize(count, to)
    for i = 1, count or 1 do
      local action = to == 'increase' and 'workbench.action.increaseViewSize' or 'workbench.action.decreaseViewSize'
      vim.fn["VSCodeNotify"](action)
    end
  end

  vim.cmd("command! -complete=file -nargs=? Split call v:lua.split('h', <q-args>)")
  vim.cmd("command! -complete=file -nargs=? Vsplit call v:lua.split('v', <q-args>)")
  vim.cmd("command! -complete=file -nargs=? New call v:lua.split('h', '__vscode_new__')")
  vim.cmd("command! -complete=file -nargs=? Vnew call v:lua.split('v', '__vscode_new__')")
  vim.cmd(
    "command! -bang Only if <q-bang> == '!' | call v:lua.closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif")

  vim.api.nvim_set_keymap('n', '<C-w>s', ':call v:lua.split("h")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-w>s', ':call v:lua.split("h")<CR>', { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', '<C-w>v', ':call v:lua.split("v")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-w>v', ':call v:lua.split("v")<CR>', { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', '<C-w>n', ':call v:lua.splitNew("h", "__vscode_new__")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-w>n', ':call v:lua.splitNew("h", "__vscode_new__")<CR>',
    { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', '<C-w>=', ':<C-u>call VSCodeNotify("workbench.action.evenEditorWidths")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-w>=', ':<C-u>call VSCodeNotify("workbench.action.evenEditorWidths")<CR>',
    { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', '<C-w>>', ':<C-u>call v:lua.manageEditorSize(v:count, "increase")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-w>>', ':<C-u>call v:lua.manageEditorSize(v:count, "increase")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-w>+', ':<C-u>call v:lua.manageEditorSize(v:count, "increase")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-w>+', ':<C-u>call v:lua.manageEditorSize(v:count, "increase")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-w><', ':<C-u>call v:lua.manageEditorSize(v:count, "decrease")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-w><', ':<C-u>call v:lua.manageEditorSize(v:count, "decrease")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-w>-', ':<C-u>call v:lua.manageEditorSize(v:count, "decrease")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-w>-', ':<C-u>call v:lua.manageEditorSize(v:count, "decrease")<CR>',
    { noremap = true, silent = true })

  -- Better Navigation
  vim.api.nvim_set_keymap('n', '<C-j>', ':call VSCodeNotify("workbench.action.navigateDown")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-j>', ':call VSCodeNotify("workbench.action.navigateDown")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-k>', ':call VSCodeNotify("workbench.action.navigateUp")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-k>', ':call VSCodeNotify("workbench.action.navigateUp")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-h>', ':call VSCodeNotify("workbench.action.navigateLeft")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-h>', ':call VSCodeNotify("workbench.action.navigateLeft")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-l>', ':call VSCodeNotify("workbench.action.navigateRight")<CR>',
    { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<C-l>', ':call VSCodeNotify("workbench.action.navigateRight")<CR>',
    { noremap = true, silent = true })

  -- Bind C-/ to vscode commentary
  vim.api.nvim_set_keymap('x', '<C-/>', ':call Comment()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-/>', ':call Comment()<CR>', { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', '<C-w>_', ':<C-u>call VSCodeNotify("workbench.action.toggleEditorWidths")<CR>',
    { noremap = true, silent = true })

  vim.api.nvim_set_keymap('n', '<Space>', ':call VSCodeNotify("whichkey.show")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('x', '<Space>', ':call VSCodeNotify("whichkey.show")<CR>', { noremap = true, silent = true })

  -- Relative Number
  vim.cmd("command! Nu call VSCodeCall('settings.cycle.relativeLineNumbers')")
  vim.cmd("autocmd InsertEnter * :Nu")
  vim.cmd("autocmd InsertLeave * :Nu")

  -- vim-commentary
  vim.api.nvim_set_keymap('x', 'gc', '<Plug>VSCodeCommentary', {})
  vim.api.nvim_set_keymap('n', 'gc', '<Plug>VSCodeCommentary', {})
  vim.api.nvim_set_keymap('o', 'gc', '<Plug>VSCodeCommentary', {})
  vim.api.nvim_set_keymap('n', 'gcc', '<Plug>VSCodeCommentaryLine', {})

  -- Theme Changer
  local function setCursorLineNrColorInsert(mode)
    if mode == "i" then
      vim.fn["VSCodeNotify"]('nvim-theme.nvimColorInsert')
    elseif mode == "r" then
      vim.fn["VSCodeNotify"]('nvim-theme.nvimColorReplace')
    end
  end

  vim.cmd("augroup CursorLineNrColorSwap")
  vim.cmd("autocmd!")
  vim.cmd("autocmd ModeChanged *:[vV\\x16]* call VSCodeNotify('nvim-theme.nvimColorVisual')")
  vim.cmd("autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.nvimColorReplace')")
  vim.cmd("autocmd InsertEnter * call setCursorLineNrColorInsert(v:insertmode)")
  vim.cmd("autocmd InsertLeave * call VSCodeNotify('nvim-theme.nvimColorNormal')")
  vim.cmd("autocmd CursorHold * call VSCodeNotify('nvim-theme.nvimColorNormal')")
  vim.cmd("augroup END")
else
  require("config")
end
