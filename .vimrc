" ==========================================================
" File Name:    .vimrc
" Author:       juanpabloaj
" Version:      0.3
" ==========================================================

" load plugins in .vim/bundle
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

" no compatible con vi
set nocompatible 

set modelines=0

syntax on
set tabstop=4 ""numero de espacios por un tab
set sw=4 ""numero de espacios por indent
set softtabstop=4
"set expandtab

set background=dark
set backspace=eol,start,indent
set encoding=utf-8
set wrap

set nu
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
"set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
if v:version >= 703
    set relativenumber
    set undofile
endif

"set textwidth=79
"set formatoptions=qrn1
"set colorcolumn=85

set statusline=%f\ %{fugitive#statusline()}%<%h%m%r%=%-0.(l=%03l,c=%02c%V,tL=%L%)\%h%m%r%=%-16(,bf=%n%Y%)\%P\*%=%{FileTime()}
set rulerformat=%15(%c%V\ %p%%%)

" so ~/.vim/misFunciones.vim

au FocusLost * :wa
" map {{{
let mapleader = ","
nnoremap j gj
nnoremap k gk
nnoremap ,ve :sp ~/.vimrc<CR>
nnoremap ,vd :sp ~/.vim<CR>
nnoremap ,vs :SnipMateOpenSnippetFiles<CR>
nnoremap ,vc :sp ~/.vim/bundle/vim-pixelmuerto/colors/pixelmuerto.vim<CR>
nnoremap ,s :so ~/.vimrc<cr>
nnoremap ,o :TlistToggle<CR>
nnoremap ,t :Translate<space>
nnoremap ,w :sp $W<CR>
nnoremap ,b :tabnew $HOME/.bashrc<CR>
nnoremap ,f :find 
" fugitive : git plugin
nnoremap ,gd :Gdiff<CR>
nnoremap ,gc :Gcommit -a<CR>
nnoremap ,gs :Gstatus<CR>
nnoremap ,gw :Gwrite<CR>
nnoremap ,gr :Gread<CR>
nnoremap ,g0 :w <bar> Git diff -U0<CR>
nnoremap ,g1 :w <bar> :Gdiff HEAD~1<CR>
" Extradite : addon for fugitive 
nnoremap ,ge :Extradite<CR>
let g:extradite_showhash=1
"""NERDtree
nnoremap ,n :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
"""moverse entre <++> 
nnoremap <c-j> /<++><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<++><cr>c/+>/e<cr>
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
	" showmarks {{{
	let g:showmarks_enable=0
	nnoremap <silent> <leader>mo :ShowMarksOn<CR>
	nnoremap <silent> <leader>mt :ShowMarksToggle<CR>
	"}}}
" }}}
" MRU
let MRU_Exclude_Files = '.*.extradite'  " For extradite
nnoremap ,vm :MRU<CR>
" }}}
" Busqueda {{{
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
"set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
""}}}
" mostrar caracteres especiales
set list
set listchars=tab:▸\ ,eol:¬

"" taglist
"" para que funcione debe estar instalado  exuberant-ctags 
"TlistToggle
" para las tags en ~/.ctags
let tlist_tex_settings   = 'latex;s:sections;g:graphics;l:labels'
let tlist_make_settings  = 'make;m:makros;t:targets'
au BufRead,BufNewFile *.cu set filetype=c
au BufNewFile,BufRead .*aliases set filetype=sh
""correccion ortografia {{{
"" [s ]s z= zg 
"augroup filetypedetect
au BufNewFile,BufRead *.tex,*.md,*.markdown setl spell
"augroup END
set spelllang=es
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
	silent! :execute 'source ~/.vim/templates/'. a:extension. '.snippets.vim'
endfunction

function! LoadSnippets(extension)
	silent! :execute 'source ~/.vim/templates/'. a:extension. '.snippets.vim' 
endfunction
""templates y snippets en base a la extension
:autocmd BufNewFile * silent! call LoadTemplate('%:e')
:autocmd BufRead,BufNewFile * silent! call LoadSnippets('%:e')
"}}}1
"256 colores {{{
if $TERM =~ '^xterm' || $TERM =~ '^screen'
	set t_Co=256
	colorscheme pixelmuerto
	"colorscheme xoria256
	"colorscheme calmar256
endif
""}}}
""Ultima session {{{1
""guardar y abrir
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
""limpiar la terminal al salir de vim
"autocmd VimLeave * !clear

"""por funcion a newtab
" TabMessage {{{1

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
" modificacion csv's {{{1
" ReordenarFecha {{{2

function! ReordenarFecha()
	"de dia-mes-anno a anno-mes-dia
	exe "%s/^\\([0-9][0-9]\\)-\\([0-9][0-9]\\)-\\([0-9][0-9][0-9][0-9]\\)\t/\\3-\\2-\\1\t/"
endfunction

" }}}2
" CambioFechas {{{2
" cambiar junta dos columnas anno mes a un sola fecha para mysql
function! CambioFechas(args)
	let s:meses = [
				\ [ "ene", "01" ],
				\ [ "feb", "02" ],
				\ [ "mar", "03" ],
				\ [ "abr", "04" ],
				\ [ "may", "05" ],
				\ [ "jun", "06" ],
				\ [ "jul", "07" ],
				\ [ "ago", "08" ],
				\ [ "sep", "09" ],
				\ [ "oct", "10" ],
				\ [ "nov", "11" ],
				\ [ "dic", "12" ]]
	"exe "echo ".a:args[0]
	if a:args[0] == "0"
		silent exe "%s/\t20\\([0-9][0-9]\\)\t/\t\\1\t/"
		for s:col in s:meses 
			silent exe "%s/\t".s:col[0]."\t/".s:col[1]."01\t/"
		endfor
		exe "echo "."\"Cambio formato fecha\""
	endif
	if a:args[0] == "1"
		silent exe "%s/^20\\([0-9][0-9]\\)\t/\\1\t/"
		silent exe "%s/\t\\([0-9]\\)\t/\t0\\1\t/"
		for s:col in s:meses 
			silent exe "%s/\t".s:col[0]."\t/".s:col[1]."/"
		endfor	
	endif
endfunction

" }}}2
" }}}1
" CsvToSql {{{1
	"convierte un csv a sql, solo el ultimo campo numerico
function! CsvToSql(entrada)
	"exe "%s/\(09[0-9][0-9]01\);/\1;0-10;/"
	exe "%s/ //g"
	exe "%s/;/','/g" 
	exe "%s/^/INSERT INTO `".a:entrada."` VALUES ('/"
	exe "%s/$/);/"
	exe "%s/,'\\([0-9,.]*\\));$/,\\1);/" 
endfunction
command! -nargs=+ -complete=command CsvToSql call CsvToSql(<q-args>)

" }}}1
" CommentLines {{{1
" comment out highlighted lines according to file type
" put a line like the following in your ~/.vim/filetype.vim file
" and remember to turn on filetype detection: filetype on
" au! BufRead,BufNewFile *.sh,*.tcl,*.php,*.pl let Comment="#"
" if the comment character for a given filetype happens to be @
" then use let Comment="\@" to avoid problems...

function! CommentLines()
  "let Comment="#" " shell, tcl, php, perl
  exe ":s@^@".g:Comment."@g"
  exe ":s@$@".g:EndComment."@g"
endfunction
" map visual mode keycombo 'co' to this function
vmap co :call CommentLines()<CR>

" }}}1
function! FileTime() "{{{
  let ext=tolower(expand("%:e"))
  let fname=tolower(expand('%<'))
  let filename=fname . '.' . ext
  let msg=""
  let msg=msg." ".strftime("(Modified %b,%d %y %H:%M:%S)",getftime(filename))
  return msg
endfunction
"}}}
