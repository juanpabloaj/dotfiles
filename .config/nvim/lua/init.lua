vim.g.mapleader = ","

-- remember to install a patched font
-- brew tap homebrew/cask-fonts
-- brew install --cask   font-roboto-mono-nerd-font
-- and set it in your terminal
-- iterm -> preferences -> profiles -> text -> font -> roboto mono nerd font
require("nvim-web-devicons").setup()

require("oil").setup()

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "_", ":split<CR>:Oil<CR>", { desc = "Open split parent directory" })

require("nvim-tree").setup()

vim.keymap.set("n", "<leader>n", ':NvimTreeToggle<cr>', { desc = "open nvim tree" })

-- don't remove lua, vim or vimdoc
require'nvim-treesitter.configs'.setup{
  ensure_installed = {"c", "lua", "vim", "vimdoc", "elixir", "heex", "javascript", "go"},
  -- to install another language manually :TSInstall supported_language

  highlight={
    enable=true
  },
}

require'lspconfig'.gopls.setup{
  settings = {
    gopls = {
      buildFlags = {"-tags=integration"},
    },
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
