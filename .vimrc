" ==========================================================
" File Name:	.vimrc
" Author:		juanpabloaj
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
	set history=1000
	syntax on
	set tabstop=4 "numero de espacios por un tab
	set sw=4 "numero de espacios por indent
	set softtabstop=4
	set expandtab
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
	set title
    set tildeop " ~2w
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
set completeopt=longest,menuone",preview
" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="
au FocusLost * :wa
" mostrar caracteres especiales
set list
set listchars=tab:▸\ ,eol:¬
runtime macros/matchit.vim
set shortmess=atI
" Backups {{{
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
" }}}
" }}}
" statusline {{{
	set statusline=
	set statusline+=%f\ %{SyntasticStatuslineFlag()}
	set statusline+=%{FugitiveStatuslineShort()}
	set statusline+=%<%h%m%r%=%-0.(%{HasPaste()}\ %2*%{HasNeoComplcache()}\ L%03l/%L\ C%02c%V%)\%h%m%r%=%-16(\ B%{BufferWidget()}\ %y%)
	set statusline+=%3*%P%=%{FileTime()}
	set rulerformat=%15(%c%V\ %p%%%)
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
	fun! HasNeoComplcache() "{{{
		return !neocomplcache#is_locked() ? "nCC" : ""
	endf "}}}
	fun! FugitiveStatuslineShort() "{{{
		return substitute(fugitive#statusline(),"master","M","g")
	endf "}}}
" }}}
" map {{{
let mapleader = ","
" spanish keyboards
ino ç <esc>
vn ç <esc>
nn ñ :
vn ñ :
nnoremap <silent><leader>ve :sp $D/.vimrc<CR>
" <c-a> is for screen or tmux
nn <silent><c-A> <c-a>
nn <silent><leader>vS :vs $D/.vimrc<CR>
nn <silent><leader>vE :tabnew $D/.vimrc<CR>
nn <leader>vd :sp ~/.vim<CR>
nn <leader>vc :sp ~/.vim/bundle/vim-pixelmuerto/colors/pixelmuerto.vim<CR>
nn <leader>vt :exec "sp $D/.vim/templates/".&ft.".snippets.vim"<CR>
nn <leader>vcl :setl cursorline!<CR>
nn <silent><leader>s :so ~/.vimrc<CR>
nn <leader>t :Translate<space>
nn <silent><leader>j :setl more!<bar>jumps<bar>setl more!<cr>
nn <leader>w :sp $W<CR>
nn <leader>b :tabnew $HOME/.bashrc<CR>
nn <leader>tn :tabnew 
nn <silent><leader>tc :tabclose<CR>
nn <silent>gt : exec tabpagenr('$') == 1 ? 'bn' : 'tabnext'<CR>
nn <silent>gT : exec tabpagenr('$') == 1 ? 'bp' : 'tabprevious'<CR>
nn <silent><leader>f :find 
nn <silent><leader>r :registers<CR>
nn <leader>! :w<CR>:!<up><CR>
nn <silent><leader>e :call LastEvernote()<CR>
nn <silent> <leader>vn :call ToggleNumber()<CR>
nn <silent> <leader>vl :setl list!<CR>
nn <silent> <leader>vp :call TogglePaste()<CR>
nn <leader>s<space> :%s/\s\+$//c<CR>
nn <silent><leader>? :map <buffer><CR>
" moverse entre <++>; si hay fold abrir
nnoremap <c-j> /<++><cr>zvc/+>/e<cr>
inoremap <c-j> <ESC>/<++><cr>c/+>/e<cr>
" navigation
nn <leader><Down> :cnext<cr>zvzz
nn <leader><Up> :cprevious<cr>zvzz
nn j gj
nn k gk
vno j gj
vno k gk
" no ex mode ; press gQ
nn Q <nop>
nn <silent>ZA :qa<CR>
nn <silent>ZD :bd<CR>
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
	" replace {{{
		vno <leader>s :s//<left>
        nn <Leader>S :%s/<c-r>=expand("<cword>")<cr>//c<left><left>
	" }}}
au! Filetype vim nn <leader>h :h <c-r>=expand("<cword>")<cr><cr>
" }}}
" abbreviate {{{
	ia @@ jpabloaj@gmail.com
	ia @0 juanpablo <jpabloaj@gmail.com>
	ia @1 jpabloaj at gmail dot com
" }}}
" search {{{
nnoremap / /\v
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
	nnoremap <Leader>vg :GundoToggle<CR>
	" taglist {{{
	" debe estar instalado exuberant-ctags
	nn <silent><Leader>l :TlistToggle<CR>
	"}}}
	" object indent {{{
        " sort indent block
		nmap <Leader>ss vii!sort<cr>
	" }}}
	" fugitive {{{
	nnoremap <silent><leader>gd :Gdiff<CR>
	nn <silent><leader>gc :Gcommit -a<CR>
	nn <silent><leader>gs :Gstatus<CR>
	nn <silent><leader>gw :Gwrite<CR>
	nn <silent><leader>gr :Gread<CR>
	nn <silent><leader>gb :Gblame<CR>
	nn <silent><leader>g0 :w <bar> Git diff -U0<CR>
	nn <silent><leader>g1 :w <bar> :Gdiff HEAD~1<CR>
	nn <silent><Leader>gD <c-w>h:bd<cr>
	" }}}
	" vimshell {{{
		let g:vimshell_user_prompt='substitute(getcwd(),eval("$HOME"),"~","")'
		let g:vimshell_prompt = '$ '
		nn <silent><leader>Ç :sp <bar> VimShell<cr>
		nn <silent><leader>ç :sp <bar> VimShellBufferDir<cr>
	" }}}
	" Extradite : addon for fugitive {{{
	nnoremap <silent><leader>ge :Extradite<CR>
	let g:extradite_showhash=1
	" }}}
	" NERDtree {{{
	nnoremap <silent><leader>n :NERDTreeToggle<CR>
	let NERDTreeShowBookmarks=1
	" }}}
	" snipmate {{{
		nn <silent><Leader>vs :SnipMateOpenSnippetFiles<CR>
		" &cms : commentstring
		fun! AddFolding(text)
			return substitute(a:text,'\n'," ".substitute(&cms,'%s',"",'g')." {{{\n",1)."\n".substitute(&cms,'%s',"",'g')." }}}"
		endf
		" TODO function AddDocumentation; char @
		fun! SnippetsWithFolding(scopes, trigger, result)
		" hacky: temporarely remove this function to prevent infinite recursion:
		call remove(g:snipMateSources, 'with_folding')
		" get list of snippets:
		let result = snipMate#GetSnippets(a:scopes, substitute(a:trigger,'_\(\*\)\?$','\1',''))
		let g:snipMateSources['with_folding'] = funcref#Function('SnippetsWithFolding')
		" add folding:
		for k in keys(result)
		  let a:result[k.'_'] = map(result[k],'AddFolding(v:val)')
		endfor
		endf
		" force setting default:
		runtime plugin/snipMate.vim
		" add our own source
		let g:snipMateSources['with_folding'] = funcref#Function('SnippetsWithFolding')
	" }}}
	" Syntastic {{{
	let g:syntastic_enable_signs = 0
	"let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
	" }}}
	" showmarks {{{
	let g:showmarks_enable=0
	nn <silent> <leader>mo :ShowMarksOn<CR>
	nn <silent> <leader>mt :ShowMarksToggle<CR>
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
	" BufferWidget {{{
		let g:buffer_widget_view='bars'
	" }}}
	" Ack {{{
		" you have to install ack
		nn <leader>a :Ack! --nobinary <cword><CR>
	" }}}
	" surround {{{
		" surround example, zf es more simple
		"autocmd FileType * let b:comChar = g:commentChar[&ft] |
		"\ let b:surround_{char2nr('z')}=b:comChar."{{{ \r ".b:comChar."}}}" |
		"\ let b:surround_{char2nr('Z')}="\" \<++\> {{{ \r \"}}}" |
        " in latex word to bf ysiw* " complete line with yss*
		autocmd FileType tex let g:surround_42 = "{\\bf \r}"
	"}}}
	" simplenote {{{
		if filereadable(expand('~').'/.simplenoterc')
			source ~/.simplenoterc
		endif
		for i in ['l','t','u','d','n']
			exe "nn <silent><leader>s".i." :Simplenote -".i."<CR>"
		endfor
		let g:SimplenoteUseMarkdown=1
	" }}}
	" rainbow {{{
		nn <silent><leader>R :RainbowParenthesesToggle<cr>
		func! s:rainbow_load()
			RainbowParenthesesLoadRound
			RainbowParenthesesLoadSquare
		endfunc
		au VimEnter * RainbowParenthesesToggle
		"au FileType *.py RainbowParenthesesLoadRound
		au FileType * au Syntax * cal s:rainbow_load()
	" }}}
"}}}
" spell {{{
" [s ]s z= zg
"augroup filetypedetect
au FileType tex,mkd,markdown setl spell
"augroup END
set spelllang=es,en
""}}}
" Folding {{{
" metodo de folding
set fdm=marker
" auto cerrado
"set fcl=all
"}}}
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
	highlight whitespaceEOL term=reverse ctermbg=Grey guibg=Grey
	au Syntax * syn match whitespaceEOL /\s\+\(\%#\)\@!$/ containedin=ALL
	" don't show whitespaceEOL in unite ft
	au! Filetype unite,vimshell,tlibInputList hi whitespaceEOL ctermbg=bg
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
	au! CmdwinEnter * nn <silent><buffer> q :q<CR>
	autocmd! bufwritepost .vimrc source ~/.vimrc
	augroup longLines
		au!
		au! filetype zsh,sh,vim
			\ syn match ColorColumn /\%>80v.\+/ containedin=ALL
	augroup END
	" never mix tabs and spaces
	au FileType vim,python if search('^\t') >0 |
		\ exe "setl noexpandtab" |
		\ endif
	" Restore cursor position
	autocmd BufReadPost *
	  \ if line("'\"") > 1 && line("'\"") <= line("$") |
	  \   exe "normal! g`\"" |
	  \ endif
	if exists('+relativenumber')
		autocmd InsertEnter * setl nu
		autocmd InsertLeave * setl rnu
		autocmd WinLeave *
			\ if &rnu==1 |
			\ exe "setl norelativenumber" |
			\ exe "setl nu" |
			\ endif
		autocmd WinEnter *
			\ if &rnu==0 |
			\ exe "setl rnu" |
			\ endif
	endif
	autocmd InsertEnter * hi statusline ctermfg=255
	autocmd InsertLeave * hi statusline ctermfg=250
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
" Hg {{{
" Inspirated in http://bitbucket.org/sjl/dotfiles <Steve Losh>
	function! s:HgDiff() " {{{
		diffthis
		let fn = expand('%:p')
		let ft = &ft
		wincmd v
		edit __hgdiff_orig__
		setlocal buftype=nofile
		normal ggdG
		execute "silent r!hg cat --rev . " . fn
		normal ggdd
		execute "setlocal ft=" . ft
		diffthis
		diffupdate
		autocmd! BufWinLeave __hgdiff_orig__ bdelete __hgdiff_orig__ | diffoff | so ~/.vimrc
	endf
	command! -nargs=0 HgDiff call s:HgDiff()
	nnoremap <leader>hd :HgDiff<cr>
	" }}}
	function! s:HgBlame() " {{{
		let fn = expand('%:p')
		wincmd v
		wincmd h
		edit __hgblame__
		vertical resize 28
		setlocal scrollbind winfixwidth nolist nowrap nonumber buftype=nofile ft=none
		normal ggdG
		execute "silent r!hg blame -undq " . fn
		normal ggdd
		execute ':%s/\v:.*$//'
		wincmd l
		setlocal scrollbind
		syncbind
		autocmd! BufWinLeave __hgblame__ bdelete __hgblame__ | so ~/.vimrc
	endf
	command! -nargs=0 HgBlame call s:HgBlame()
	nnoremap <leader>hb :HgBlame<cr>
	" }}}
" }}}
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
fun! ToggleNumber() "{{{
	if exists('+relativenumber')
		:exec &nu==&rnu? "setl nu!" : "setl rnu!"
	else
		setl nu!
	endif
endf "}}}
fun! LastEvernote() "{{{
	" a better solution is with evernote api
	let evernoteDir=expand("$HOME")."/Library/Application*Support/Evernote/data"
	let dataDir=system("ls -trlh ".evernoteDir."| tail -n 1| awk '{print $NF}'")
	let contentDir=evernoteDir."/".dataDir."/content"
	let contentDir=substitute(contentDir,"\n","",'g')
	let note=system("ls -trlh ".contentDir." | tail -n 1| awk '{print $NF}'")
	let note=substitute(note,"\n","",'g')
	sil! exec 'sp '.contentDir.'/'.note.'/content.html'
	sil! exec '1s/>/>\r/g'
	sil! exec '%s/<br.*\/>/<br\/>\r/g'
	sil! exec '%s/<\//\r<\//g'
	sil! exec 'g/^\s*$/d'
	normal gg
	sil! exec '1,4fo'
	sil! exec '$-1,$fo'
	setl spell
endf
"}}}
