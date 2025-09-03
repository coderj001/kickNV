if true then
  return {
    'jake-stewart/auto-cmdheight.nvim',
    lazy = true,
    opts = {
      max_lines = 5,
      duration = 2,
      remove_on_key = true,
      clear_always = false,
    },
  }
else
  return {}
end
