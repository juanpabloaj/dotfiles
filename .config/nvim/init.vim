" no 'syntax on' here: it triggers filetype detection of the startup file
" at this point, before the rest of this file is sourced; plug#end() runs
" 'syntax enable' later anyway
set showcmd
set showmatch
set showmode
set ruler
set number
set backspace=eol,start,indent
set laststatus=2
set formatoptions+=o
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set fdm=manual

set noerrorbells
set modeline
set linespace=0
set wildmenu
set wildmode=list:longest
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store?                      " OSX files
set wildignore+=*.beam                           " elixir files
" <C-x><C-o> to trigger omnicompletion omnifunc
set completeopt=menuone,longest
"set completeopt=menuone,longest,preview
" comment preview if it is too noisy, ",preview

set list
set listchars=tab:▸\ ,eol:¬,trail:-,extends:»,precedes:«,nbsp:+

set spelllang=es,en

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'airblade/vim-gitgutter'

Plug 'vim-airline/vim-airline'

Plug 'saghen/blink.cmp', { 'tag': 'v1.*' }

"Plug 'github/copilot.vim'

" I tried neosnippet but I'm not used to the keymap
"Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'

Plug 'rafamadriz/friendly-snippets'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"Plug 'w0rp/ale'

Plug 'preservim/tagbar'
Plug 'preservim/nerdcommenter'

Plug 'luochen1990/rainbow'

Plug 'ap/vim-css-color'

Plug 'lervag/vimtex'

"Plug 'sheerun/vim-polyglot'
Plug 'johngrib/vim-git-msg-wheel'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'stevearc/oil.nvim'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'nvim-tree/nvim-tree.lua'

"Plug 'kevinhwang91/nvim-bqf'

Plug 'neovim/nvim-lspconfig'

" elixir
"Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
"Plug 'slashmili/alchemist.vim'

Plug 'nvim-lua/plenary.nvim'
"Plug 'elixir-tools/elixir-tools.nvim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': 'v0.2.2' }
"Plug 'nvim-telescope/telescope-frecency.nvim'
"Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'tris203/precognition.nvim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'prettier/vim-prettier', {
	  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" javascript
" Plug 'ludovicchabant/vim-gutentags'

" colorscheme
Plug 'joshdick/onedark.vim'
Plug 'freeo/vim-kalisi'
Plug 'juanpabloaj/vim-pixelmuerto'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/seoul256.vim'
Plug 'whatyouhide/vim-gotham'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'sjl/badwolf'
Plug 'folke/tokyonight.nvim'
Plug 'rebelot/kanagawa.nvim'

call plug#end()

" to load lua/init.lua
" and avoid conflicts between init.vim and init.lua
" I put it here to load the plugins first
lua require('init')

set background=dark
"colorscheme gruvbox | set background=dark
"colorscheme kanagawa-dragon
colorscheme kanagawa-wave

"autocmd! bufwritepost init.vim source ~/.config/nvim/init.vim

"let mapleader = ","
nnoremap <silent><leader>ve :sp ~/.config/nvim/init.vim<CR>
nnoremap <silent><leader>we :sp ~/src/blog/wiki<CR>

" spanish keyboards
ino ç <esc>
ino ¬ \
vn ç <esc>
nn ñ :
vn ñ :
"
" no ex mode ; press gQ
nn Q gq

" insert hour/date
inoremap <C-d> <C-r>=strftime('%Y-%m-%dT%H:%M:%S')<CR>
inoremap <C-t> <C-r>=strftime('%H:%M:%S')<CR>

nn <leader>tn :tabnew 
nn <silent>gt : exec tabpagenr('$') == 1 ? 'bn' : 'tabnext'<CR>
nn <silent>gT : exec tabpagenr('$') == 1 ? 'bp' : 'tabprevious'<CR>

nn <silent><leader>r :registers<CR>
nn <leader>s<space> :%s/\s\+$//c<CR>
"
" search {{{
nnoremap / :set hls<cr>/\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch
nnoremap <silent><leader><space> :setl hlsearch!<cr>
"nnoremap <tab> %
"vnoremap <tab> %
nnoremap n nzzzv
nnoremap N Nzzzv
""}}}

" terminal
nn <silent><leader>Ñ :split term://%:p:h//bash -c 'bash -l'<CR>A
nn <silent><leader>ñ :split term://bash -l<CR>A
tnoremap <Esc> <C-\><C-n>

" window matches instead of 'syn match': they survive :syn clear and also
" show up in treesitter-highlighted buffers (markdown in nvim 0.12)
highlight whitespaceEOL term=reverse ctermbg=Grey guibg=Grey
augroup whitespace_eol
  autocmd!
  autocmd VimEnter,WinEnter * if empty(&buftype) && !exists('w:whitespaceEOL_id')
        \ | let w:whitespaceEOL_id = matchadd('whitespaceEOL', '\s\+\(\%#\)\@!$')
        \ | endif
augroup END

" plugins configuration

" ssh over oil
" :e oil-ssh://ssh_alias/

" nerdtree
"nnoremap <silent><leader>n :NERDTreeToggle<CR>

" lspconfig
" rename a reference over all the project
" lua vim.lsp.buf.rename()

" fzf
" fzf-vim-commands
nnoremap <silent><leader>F :FZF<CR>
nnoremap <silent><leader>b :Buffers<CR>
nn <silent><leader>fh :History<CR>

autocmd! FileType fzf tnoremap <buffer> <Esc> <Esc>

let g:fzf_commits_log_options = '--color=always --format="%C(yellow)%h%Creset %s %C(green)%cr%Creset %C(dim white)%an%Creset"'

" telescope
nnoremap <silent><leader>T :Telescope<CR>

" elixir
let g:mix_format_on_save = 1

" vim-go
let g:go_fmt_command = "goimports"
"let g:go_def_mode = 'gopls'
"let g:go_fmt_command="gopls"
let g:go_gopls_gofumpt=1

"let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_enabled= ['errcheck', 'misspell', 'gosimple', 'govet', 'staticcheck', 'typecheck', 'unused']
let g:go_metalinter_autosave_enabled=g:go_metalinter_enabled
let g:go_metalinter_autosave = 1

" fugitive
nnoremap <silent><leader>gd :Gvdiff<CR>
nn <silent><leader>gc :Git commit<CR>
nn <silent><leader>gs :Git<CR>
nn <silent><leader>gw :Gwrite<CR>
nn <silent><leader>gr :Gread<CR>
nn <silent><leader>gb :Git blame<CR>

" to ignore whitespace changes in git diff and vimdiff
" set diffopt+=iwhite,iwhiteall,iwhiteeol
" to ignore whitespaces at end of line only
set diffopt+=iwhiteeol

" rainbow
let g:rainbow_active = 1

" Tagbar
nn <silent><Leader>l :TagbarToggle<CR>

" FileType settings live in after/ftplugin/*.vim
