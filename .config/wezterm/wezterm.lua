local wezterm = require 'wezterm'

return {
  default_prog = { '/bin/bash', '-l' },

  --font = wezterm.font('JetBrains Mono', { weight = 'Medium' }),
  font_size = 14,

  initial_cols = 120,
  initial_rows = 44,

  keys = {
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'D',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  }
}
