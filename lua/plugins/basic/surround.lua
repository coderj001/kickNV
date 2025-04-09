if not require('core').plugin_groups.mini.ai_move then
  return { "tpope/vim-surround", event = "BufEnter" }
else
  return {}
end
