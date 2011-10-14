" ==========================================================
" File Name:    .vimrc
" Author:       juanpabloaj
" Url:			http://j.mp/dotvimrc
" ==========================================================
" preamble {{{
" load plugins in .vim/bundle
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on
" no compatible con vi
set nocompatible 
" }}}
" basic options {{{
" basic {{{
	set encoding=utf-8
	set modelines=0
	set autoindent
	set showmode
	set showcmd
	set hidden
	set visualbell
	set cursorline
	set ttyfast
	set ruler
	set backspace=eol,start,indent
	set nu
	set laststatus=2
	set history=100
	syntax on
	set tabstop=4 "numero de espacios por un tab
	set sw=4 "numero de espacios por indent
	set softtabstop=4
	"set expandtab
	set background=dark
	set wrap
	set scrolloff=3
	if v:version >= 703
		set relativenumber
		set undofile
		set undodir=~/.vim/tmp/undo//     " undo files
	endif
	"set textwidth=79
	"set formatoptions=qrn1
	"set colorcolumn=85
" }}}
" Wildmenu completion {{{
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
" }}}
" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="
au FocusLost * :wa
" mostrar caracteres especiales
set list
set listchars=tab:▸\ ,eol:¬
" Backups {{{
"set backupdir=~/.vim/tmp/backup// " backups
"set directory=~/.vim/tmp/swap//   " swap files
"set backup                        " enable backups
" }}}
" }}}
" statusline {{{
	set statusline=
	set statusline+=%f\ %{SyntasticStatuslineFlag()}
	set statusline+=%{FugitiveStatuslineShort()}
	set statusline+=%<%h%m%r%=%-0.(%{HasPaste()}\ %2*%{HasNeocomplcache()}\ L%03l/%L\ C%02c%V%)\%h%m%r%=%-16(\ B%n\ %y%)
	set statusline+=%3*\%P\*%=%{FileTime()}
	set rulerformat=%15(%c%V\ %p%%%)
" }}}
" map {{{
let mapleader = ","
nnoremap <leader>ve :sp ~/.vimrc<CR>
nn <leader>vd :sp ~/.vim<CR>
nn <leader>vc :sp ~/.vim/bundle/vim-pixelmuerto/colors/pixelmuerto.vim<CR>
nn <leader>vcl :setl cursorline!<CR>
nn <leader>s :so ~/.vimrc<cr>
nn <leader>t :Translate<space>
nn <leader>w :sp $W<CR>
nn <leader>b :tabnew $HOME/.bashrc<CR>
nn <leader>bn :bn<CR>
nn <leader>tn :tabnew 
nn <leader>f :find 
nn <silent> <leader>vn :call ToggleNumber()<CR>
nn <silent> <leader>vl :setl list!<CR>
nn <silent> <leader>vp :call TogglePaste()<CR>
nn <leader>s<space> :/\s\+$/<CR>
nn <silent><leader>? :map <buffer><CR>
" moverse entre <++>
nnoremap <c-j> /<++><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<++><cr>c/+>/e<cr>
" navigation
nnoremap <leader><Down> :cnext<cr>zvzz
nnoremap <leader><Up> :cprevious<cr>zvzz
nnoremap j gj
nnoremap k gk
" no ex mode ; press gQ
nn Q <nop>
nn ZA :qa<CR>
" marks {{{ 
	fun! ShowGlobalMarks() "{{{
		try
			marks ABCDEFGHIJKLMNOPQRSTUVWXYZ
		catch /E283:/
		endtry
	endf 
	nnoremap <silent> <leader>mu :call ShowGlobalMarks()<CR>
	"}}}
	fun! ShowNumberMarks() "{{{
		try
			marks 0123456789
		catch /E283:/
		endtry
	endf 
	nnoremap <silent> <leader>mf :call ShowNumberMarks()<CR>
	"}}}
	fun! ShowLocalMarks() "{{{
		try
			marks abcdefghijklmnopqrstuvwxyz
		catch /E283:/
		endtry
	endf 
	nnoremap <silent><leader>ml :call ShowLocalMarks()<CR>
	"}}}
" }}}
" }}}
" abbreviate {{{
	ia @@ jpabloaj@gmail.com
	ia @0 jpabloaj at gmail dot com
" }}}
" search {{{
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
"set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <silent><leader><space> :setl hlsearch!<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap n nzzzv
nnoremap N Nzzzv
""}}}
" para las tags en ~/.ctags {{{
	let tlist_tex_settings   = 'latex;s:sections;g:graphics;l:labels'
	let tlist_make_settings  = 'make;m:makros;t:targets'
" }}}
" filetype {{{
	au BufRead,BufNewFile *.cu setl filetype=c
	au BufNewFile,BufRead .*aliases setl filetype=sh
	au BufNewFile,BufRead *.zsh-theme setl filetype=zsh
" }}}
" plugins configuration {{{
	nnoremap ,vg :GundoToggle<CR>
	nnoremap ,vs :SnipMateOpenSnippetFiles<CR>
	" taglist {{{
	" debe estar instalado exuberant-ctags
	nnoremap ,o :TlistToggle<CR>
	"}}}
	" fugitive {{{
	nnoremap ,gd :Gdiff<CR>
	nnoremap ,gc :Gcommit -a<CR>
	nnoremap ,gs :Gstatus<CR>
	nnoremap ,gw :Gwrite<CR>
	nnoremap ,gr :Gread<CR>
	nn ,gb :Gblame<CR>
	nnoremap ,g0 :w <bar> Git diff -U0<CR>
	nnoremap ,g1 :w <bar> :Gdiff HEAD~1<CR>
	" }}}
	" Extradite : addon for fugitive {{{
	nnoremap ,ge :Extradite<CR>
	let g:extradite_showhash=1
	" }}}
	" NERDtree {{{
	nnoremap <silent><leader>n :NERDTreeToggle<CR>
	let NERDTreeShowBookmarks=1
	" }}}
	" Syntastic {{{
	let g:syntastic_enable_signs = 0
	let g:syntastic_disabled_filetypes = ['html', 'xhtml']
	"let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
	" }}}
	" showmarks {{{
	let g:showmarks_enable=0
	nnoremap <silent> <leader>mo :ShowMarksOn<CR>
	nnoremap <silent> <leader>mt :ShowMarksToggle<CR>
	"}}}
	" unite {{{
		nn <silent> <leader>ub :<C-u>Unite buffer<CR>
		nn <silent> <leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
		nn <silent> <leader>ur :<C-u>Unite -buffer-name=register register<CR>
		nn <silent> <leader>um :<C-u>Unite file_mru<CR>
		nn <silent> <leader>uu :<C-u>Unite buffer file_mru<CR>
		nn <silent> <leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
		au FileType unite inoremap <buffer><expr> s unite#do_action('split')
		au FileType unite nnoremap <buffer><expr> s unite#do_action('split')
	" }}}
	" markup {{{
		nn <silent> <leader>mm :MkdToHtml<CR>
	" }}}
	" neocomplcache {{{
		let g:neocomplcache_enable_at_startup = 1
		"let g:neocomplcache_snippets_disable_runtime_snippets = 1
		let g:neocomplcache_snippets_dir='~/.vim/bundle/snipmate-snippets/snippets'
		nnoremap <silent><leader>nt :NeoComplCacheToggle<CR>
	" }}}
"}}}
" spell {{{
" [s ]s z= zg 
"augroup filetypedetect
au BufNewFile,BufRead *.tex,*.md,*.markdown setl spell
"augroup END
set spelllang=es,en
""}}}
" Folding {{{
""metodo de folding
set fdm=marker
""auto cerrado
"set fcl=all
""}}}
" Templates + manual snippets {{{1
function! LoadTemplate(extension)
	silent! :execute '0r ~/.vim/templates/'. a:extension. '.tpl'
	silent! normal Gddgg
	silent! :execute 'source ~/.vim/templates/'. a:extension. '.snippets.vim'
endfunction

function! LoadSnippets(extension)
	silent! :execute 'source ~/.vim/templates/'. a:extension. '.snippets.vim' 
endfunction
" templates y snippets en base a la extension
autocmd BufNewFile * silent! call LoadTemplate('%:e')
autocmd BufRead,BufNewFile * silent! call LoadSnippets('%:e')
"}}}1
"256 colores {{{
if $TERM =~ '^xterm' || $TERM =~ '^screen' || $TERM =~ 'rxvt'
	set t_Co=256
	colorscheme pixelmuerto
	"colorscheme xoria256
	"colorscheme calmar256
endif
""}}}
" highlight {{{
	highlight whitespaceEOL term=reverse ctermbg=Grey  guibg=Grey
	match whitespaceEOL /\s\+$/
" }}}
" Ultima session {{{1
" guardar y abrir
function! SaveSession()
	execute 'mksession! ~/.vim/sessions/session.vim'
endfunction
function! LoadSession()
	if argc() == 0
		execute 'source ~/.vim/sessions/session.vim'
	endif
endfunction
"autocmd VimEnter * call LoadSession()
"autocmd VimLeave * call SaveSession()
"}}}1
" autocmd {{{
	" limpiar la terminal al salir de vim
	"autocmd VimLeave * !clear
	" When vimrc is edited, reload it
	autocmd! bufwritepost .vimrc source ~/.vimrc
" }}}
" TabMessage {{{1
" por funcion a newtab
function! TabMessage(cmd)
	set nonu
	redir => message
	silent execute a:cmd
	redir END
	set nu
	tabnew
	silent put=message
	set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
" }}}1
" Translate {{{1
" TODO make this a vim plugin 
" TODO set language as var 
" Traduccion, solo funcional con internet
function! Translate(entrada)
	let en=substitute(a:entrada," ","%20","g")
	let en = substitute(en, "[ ]*$","","")
	let  palabra= system('curl -e www.google.com "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q='.en.'&langpair=en%7Ces"')
	echo  split(strpart(palabra,stridx(palabra,"Text") + 7 ),'\"')[0]
endfunction
command! -nargs=+ -complete=command Translate call Translate(<q-args>)
" }}}1
fun! FileTime() "{{{
  let ext=tolower(expand("%:e"))
  let fname=tolower(expand('%<'))
  let filename=fname . '.' . ext
  let msg=""
  let msg=msg." ".strftime("(Mod %b,%d %y %H:%M:%S)",getftime(filename))
  return msg
endfunction
"}}}
fun! HasPaste() "{{{
	return &paste ? "paste" : ""
endf "}}}
fun! HasNeocomplcache() "{{{
	return !neocomplcache#is_locked() ? "nCC" : ""
endf "}}}
fun! ToggleNumber() "{{{
	if exists('+relativenumber')
		:exec &nu==&rnu? "setl nu!" : "setl rnu!"
	else
		setl nu!
	endif
endf "}}}
fun! TogglePaste() "{{{
	" setl paste! && remove elements for copy
	setl paste!
	if &paste
		setl nolist
		setl nonu
		:exec exists('+relativenumber') ? 'setl nornu': ''
	else
		setl list
		setl nu
		:exec exists('+relativenumber') ? 'setl rnu': ''
	endif
endf "}}}
fun! FugitiveStatuslineShort() "{{{
	return substitute(fugitive#statusline(),"master","M","g")"
endf "}}}
