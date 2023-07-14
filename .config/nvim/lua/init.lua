vim.g.mapleader = ","

-- remember to install a patched font
-- brew tap homebrew/cask-fonts
-- brew install --cask   font-roboto-mono-nerd-font
-- and set it in your terminal
-- iterm -> preferences -> profiles -> text -> font -> roboto mono nerd font
require("nvim-web-devicons").setup()

require("oil").setup()

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

require("nvim-tree").setup()

vim.keymap.set("n", "<leader>n", ':NvimTreeToggle<cr>', { desc = "open nvim tree" })

require'nvim-treesitter.configs'.setup{
  ensure_installed = { "elixir", "heex" },
  -- to install another language manually :TSInstall supported_language

  highlight={
    enable=true
  },
}
