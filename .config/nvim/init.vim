syntax on
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
set wildignore+=*.DS_Store?                      " OSX bullshit
set wildignore+=*.beam                           " elixir files
set completeopt=longest,menuone",preview

set list
set listchars=tab:▸\ ,eol:¬,trail:-,extends:»,precedes:«,nbsp:+

set spelllang=es,en

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'airblade/vim-gitgutter'

Plug 'vim-airline/vim-airline'

Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deol.nvim'

"if has('win32') || has('win64')
  "Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
"else
  "Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
"endif

Plug 'github/copilot.vim'

" I tried neosnippet but I'm not used to the keymap
"Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'psf/black'
Plug 'nvie/vim-flake8'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"Plug 'w0rp/ale'

Plug 'majutsushi/tagbar'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdcommenter'
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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neovim/nvim-lspconfig'

" elixir
"Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
"Plug 'slashmili/alchemist.vim'

Plug 'nvim-lua/plenary.nvim'
"Plug 'elixir-tools/elixir-tools.nvim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
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
Plug 'sickill/vim-monokai'
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
Plug 'catppuccin/nvim'
Plug 'rose-pine/neovim'

call plug#end()

" to load lua/init.lua
" and avoid conflicts between init.vim and init.lua
" I put it here to load the plugins first
lua require('init')

set background=dark
"colorscheme gruvbox | set background=dark
colorscheme kanagawa-dragon
colorscheme kanagawa-wave
"colorscheme catppuccin

autocmd! bufwritepost init.vim source ~/.config/nvim/init.vim

let mapleader = ","
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

" <c-a> is for screen or tmux
nn <silent><c-A> <c-a>

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
set showmatch
set hlsearch
nnoremap <silent><leader><space> :setl hlsearch!<cr>
"nnoremap <tab> %
"vnoremap <tab> %
nnoremap n nzzzv
nnoremap N Nzzzv
""}}}

" terminal
nn <silent><leader>ñ :split term://%:p:h//bash -c 'bash -l'<CR>A
nn <silent><leader>Ñ :split term://bash -l<CR>A
tnoremap <Esc> <C-\><C-n>

highlight whitespaceEOL term=reverse ctermbg=Grey guibg=Grey
au Syntax * syn match whitespaceEOL /\s\+\(\%#\)\@!$/ containedin=ALL

" plugins configuration

" nerdtree
"nnoremap <silent><leader>n :NERDTreeToggle<CR>

" lspconfig
" rename a reference over all the project
" lua vim.lsp.buf.rename()

" black
let g:black_linelength = 79
autocmd BufWritePre *.py execute ':Black'

" fzf
" fzf-vim-commands
nnoremap <silent><leader>F :FZF<CR>
nnoremap <silent><leader>b :Buffers<CR>
nn <silent><leader>fh :History<CR>

let g:fzf_commits_log_options = '--color=always --format="%C(yellow)%h%Creset %s %C(green)%cr%Creset %C(dim white)%an%Creset"'

" telescope
nnoremap <silent><leader>T :Telescope<CR>

" elixir
let g:mix_format_on_save = 1

autocmd FileType elixir call s:elixir_settings()
fun! s:elixir_settings()
  " rainbow plugin breaks elixir's syntax colors
  RainbowToggleOff
endf

" reminder
" pip install neovim
" pip install black
" reminder pip install pynvim
let g:deoplete#enable_at_startup = 1
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

" this keymap doesn't work with ultisnips
"inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"

"call deoplete#custom#option('omni_patterns', {
"\ 'go': '[^. *\t]\.\w*',
"\})

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" vim-go
let g:go_fmt_command = "goimports"
"let g:go_def_mode = 'gopls'
"let g:go_fmt_command="gopls"
let g:go_gopls_gofumpt=1

"let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_enabled= ['errcheck', 'misspell', 'gosimple', 'govet', 'staticcheck', 'typecheck', 'unused']
let g:go_metalinter_autosave_enabled=g:go_metalinter_enabled
let g:go_metalinter_autosave = 1

" unite

nn <silent> <leader>ub :<C-u>Unite buffer<CR>
nn <silent> <leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nn <silent> <leader>uF :<C-u>Unite file_rec<CR>
nn <silent> <leader>ur :<C-u>Unite -buffer-name=register register<CR>
nn <silent> <leader>um :<C-u>Unite file_mru<CR>
nn <silent> <leader>uu :<C-u>Unite buffer file_mru<CR>
nn <silent> <leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_rec file_mru bookmark file<CR>
nn <silent> <leader>un :<C-u>UniteWithBufferDir file file/new<CR>
nn <silent> <leader>ug :<C-u>UniteWithCursorWord vimgrep:`expand('%:p:h')`/**:`expand('<cword>')`<CR>
nn <leader>uG :<C-u>UniteWithCursorWord vimgrep:`expand('%:p:h')`/**:<c-r><c-w>

autocmd FileType unite call s:unite_my_settings()
fun! s:unite_my_settings()
	"inoremap <buffer><expr> s unite#do_action('split')
	nnoremap <buffer><expr> s unite#do_action('split')
	"inoremap <buffer><expr> v unite#do_action('vsplit')
	nnoremap <buffer><expr> v unite#do_action('vsplit')
	"hi whitespaceEOL ctermbg=bg
endf

"vimshell
let g:vimshell_user_prompt='substitute(getcwd(),eval("$HOME"),"~","")'
let g:vimshell_prompt = '$ '

" fugitive
nnoremap <silent><leader>gd :Gvdiff<CR>
nn <silent><leader>gc :Git commit<CR>
nn <silent><leader>gs :Git<CR>
nn <silent><leader>gw :Gwrite<CR>
nn <silent><leader>gr :Gread<CR>
nn <silent><leader>gb :Git blame<CR>

" rainbow
let g:rainbow_active = 1

" Syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_mode_map = {
  \ 'mode': 'active', 'active_filetypes': [],
  \ 'passive_filetypes': ['tex','html']}
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_cpplint_args = '--filter=-whitespace/braces'

let g:syntastic_cpp_checkers = ['cpplint', 'gcc']

let g:syntastic_aggregate_errors = 1

" Tagbar
nn <silent><Leader>l :TagbarToggle<CR>

" FileType settings

autocmd FileType make call s:make_settings()
fun! s:make_settings()
  setl noexpandtab
endf
autocmd FileType markdown call s:markdown_settings()
fun! s:markdown_settings()
  setlocal tabstop=4
  setl shiftwidth=4
  setl softtabstop=4
  setl spell
endf

augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END
