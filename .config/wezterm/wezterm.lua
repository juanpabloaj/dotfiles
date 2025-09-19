local wezterm = require 'wezterm'

return {
  default_prog = { '/bin/bash', '-l' },

  --font = wezterm.font('JetBrains Mono', { weight = 'Medium' }),
  font_size = 14,

  initial_cols = 120,
  initial_rows = 44,

  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },

  keys = {
  -- CMD-d and CMD-SHIFT-d to split panes like in iTerm2.
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
  -- wezterm uses the opposite convention of vim and tmux for vertical and horizontal splits.
  -- tmux/screen style, ctrl-a.
  {
    key = '"',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '%',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  }
}
