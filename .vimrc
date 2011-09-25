" ==========================================================
" File Name:    .vimrc
" Author:       juanpabloaj
" Version:      0.3.1
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
" statusline {{{
	set statusline=
	set statusline+=%f\ %{SyntasticStatuslineFlag()}
	set statusline+=%{FugitiveStatuslineShort()}
	set statusline+=%<%h%m%r%=%-0.(%{HasPaste()}\ %2*l=%03l,c=%02c%V,tL=%L%)\%h%m%r%=%-16(,bf=%n%Y%)
	set statusline+=%3*\%P\*%=%{FileTime()}
" }}}
set rulerformat=%15(%c%V\ %p%%%)
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
" map {{{
let mapleader = ","
nnoremap ,ve :sp ~/.vimrc<CR>
nn ,vd :sp ~/.vim<CR>
nn ,vc :sp ~/.vim/bundle/vim-pixelmuerto/colors/pixelmuerto.vim<CR>
nn ,vcl :setl cursorline!<CR>
nn ,s :so ~/.vimrc<cr>
nn ,t :Translate<space>
nn ,w :sp $W<CR>
nn ,b :tabnew $HOME/.bashrc<CR>
nn ,tn :tabnew
nn ,f :find
nn <silent> <leader>vn :call ToggleNumber()<CR>
nn ,vl :setl list!<CR>
nn ,vp :setl paste!<CR>
" moverse entre <++>
nnoremap <c-j> /<++><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<++><cr>c/+>/e<cr>
" navigation
nnoremap <leader><Down> :cnext<cr>zvzz
nnoremap <leader><Up> :cprevious<cr>zvzz
nnoremap j gj
nnoremap k gk
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
" Busqueda {{{
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
"set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :setl hlsearch!<cr>
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
	nnoremap ,n :NERDTreeToggle<CR>
	let NERDTreeShowBookmarks=1
	" }}}
	" Syntastic {{{
	let g:syntastic_enable_signs = 1
	let g:syntastic_disabled_filetypes = ['html']
	"let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
	" }}}
	" showmarks {{{
	let g:showmarks_enable=0
	nnoremap <silent> <leader>mo :ShowMarksOn<CR>
	nnoremap <silent> <leader>mt :ShowMarksToggle<CR>
	"}}}
	" MRU {{{
	let MRU_Exclude_Files = '.*.extradite'  " For extradite
	nnoremap ,vm :MRU<CR>
	" }}}
	" ctrlp {{{
	let g:ctrlp_working_path_mode = 1
	set wildignore+=*/.git/objects/* 
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
	silent! :execute 'source ~/.vim/templates/'. a:extension. '.snippets.vim'
endfunction

function! LoadSnippets(extension)
	silent! :execute 'source ~/.vim/templates/'. a:extension. '.snippets.vim' 
endfunction
" templates y snippets en base a la extension
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
" highlight {{{
	highlight whitespaceEOL term=reverse ctermbg=Grey  guibg=Grey
	match whitespaceEOL /\s\+$/
" }}}
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
" convierte un csv a sql, solo el ultimo campo numerico
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
fun! FileTime() "{{{
  let ext=tolower(expand("%:e"))
  let fname=tolower(expand('%<'))
  let filename=fname . '.' . ext
  let msg=""
  let msg=msg." ".strftime("(Modified %b,%d %y %H:%M:%S)",getftime(filename))
  return msg
endfunction
"}}}
fun! HasPaste() "{{{
	return &paste ? "paste" : ""
endf "}}}
fun! ToggleNumber() "{{{
	if exists('+relativenumber')
		:exec &nu==&rnu? "setl nu!" : "setl rnu!"
	else
		setl nu!
	endif
endf "}}}
fun! FugitiveStatuslineShort() "{{{
	return substitute(fugitive#statusline(),"master","M","g")"
endf "}}}
