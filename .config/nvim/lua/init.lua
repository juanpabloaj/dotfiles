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

vim.keymap.set("n", "<leader>nt", ':NvimTreeToggle<cr>', { desc = "open nvim tree" })

-- don't remove lua, vim or vimdoc
require'nvim-treesitter.configs'.setup{
  ensure_installed = {
    "c", "lua", "vim", "vimdoc",
    "elixir", "heex", "javascript",
    "go", "python",
    "markdown"},
  -- to install another language manually :TSInstall supported_language

  highlight={
    enable=true
  },
}

--require('bqf').setup({
    --auto_enable = true,
    --auto_resize_height = true,
    --wrap = true
--})

require'lspconfig'.gopls.setup{
  settings = {
    gopls = {
      buildFlags = {"-tags=integration"},
    },
  },
}

require("toggleterm").setup{
  shell = "bash -l",
  open_mapping = [[<c-ñ>]],
}

require('precognition').setup{
  startVisible = false,
}

--require'telescope'.load_extension('frecency')
--require("telescope").load_extension "file_browser"


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fr', ':Telescope lsp_references<CR>' , {})
vim.keymap.set('n', '<leader>fi', ':Telescope lsp_implementations<CR>' , {})
vim.keymap.set('n', '<leader>fd', ':Telescope lsp_definitions<CR>' , {})
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
--vim.keymap.set('n', '<leader>fr', ':Telescope frecency<CR>' , {})
--vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>' , {})
