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

set spelllang=es,en

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'

Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deol.nvim'

Plug 'w0rp/ale'

Plug 'majutsushi/tagbar'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'luochen1990/rainbow'

Plug 'lervag/vimtex'

Plug 'sheerun/vim-polyglot'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" elixir
Plug 'elixir-lang/vim-elixir'
Plug 'mhinz/vim-mix-format'

Plug 'ekalinin/Dockerfile.vim'

Plug 'fatih/vim-go'

Plug 'prettier/vim-prettier', {
	  \ 'do': 'npm install',
	  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

" javascript
Plug 'ludovicchabant/vim-gutentags'

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

call plug#end()

let g:seoul256_background=233
colorscheme seoul256 | set background=dark
colorscheme gruvbox | set background=dark

autocmd! bufwritepost init.vim source ~/.config/nvim/init.vim

let mapleader = ","
nnoremap <silent><leader>ve :sp ~/.config/nvim/init.vim<CR>

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

highlight whitespaceEOL term=reverse ctermbg=Grey guibg=Grey
au Syntax * syn match whitespaceEOL /\s\+\(\%#\)\@!$/ containedin=ALL

" plugins configuration

let g:deoplete#enable_at_startup = 1

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
	hi whitespaceEOL ctermbg=bg
endf

"vimshell
let g:vimshell_user_prompt='substitute(getcwd(),eval("$HOME"),"~","")'
let g:vimshell_prompt = '$ '
nn <silent><leader>Ç :VimShell<cr>
nn <silent><leader>ç :VimShellBufferDir<cr>

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" fugitive
nnoremap <silent><leader>gd :Gvdiff<CR>
nn <silent><leader>gc :Gcommit -a<CR>
nn <silent><leader>gs :Gstatus<CR>
nn <silent><leader>gw :Gwrite<CR>
nn <silent><leader>gr :Gread<CR>
nn <silent><leader>gb :Gblame<CR>

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
