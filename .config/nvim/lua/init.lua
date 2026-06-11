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
vim.keymap.set("n", "<leader>nf", ':NvimTreeFindFileToggle<cr>', { desc = "open nvim tree find file" })

--require('bqf').setup({
    --auto_enable = true,
    --auto_resize_height = true,
    --wrap = true
--})

require("blink.cmp").setup({
  keymap = { preset = "default" },
})

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      buildFlags = { "-tags=integration" },
    },
  },
})

vim.lsp.enable("gopls")

-- needs the ruff binary (asdf install ruff)
-- ruff is lint/format only; add basedpyright if python completion/goto is needed
vim.lsp.config("ruff", {
  init_options = {
    settings = {
      lineLength = 79,
    },
  },
})

vim.lsp.enable("ruff")

-- TODO: elixir lsp: install elixir-ls (or expert) and enable it here

-- format python with ruff on save (replaces the black plugin)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("python_ruff_format", {}),
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end,
})

require("toggleterm").setup{
  shell = "bash -l",
  open_mapping = [[<c-ñ>]],
  float_opts = {
    border = "curved",
    winblend = 3,
  }
}

vim.api.nvim_set_keymap('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true })

require('precognition').setup{
  startVisible = false,
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf }

    -- K (hover) is a native default; so are grn/gra/grr/gri (rename, code action, references, implementation)
    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

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
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, {})

-- diagnostics
vim.keymap.set("n", "<leader>dq", function()
  vim.diagnostic.setqflist()
end, { desc = "Diagnostics → quickfix" })
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
--vim.keymap.set('n', '<leader>fr', ':Telescope frecency<CR>' , {})
--vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>' , {})
