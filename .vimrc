" ==========================================================
" File Name:	.vimrc
" Author:		juanpabloaj
" Url:			http://j.mp/dotvimrc
" ==========================================================
" preamble {{{
" load plugins in .vim/bundle
filetype off
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
	set number
	if v:version >= 703
		set undofile
		set undodir=~/.vim/tmp/undo//     " undo files
	endif
	"set textwidth=79
	"set formatoptions=qrn1
	"set colorcolumn=85
	set winwidth=48
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

call plug#begin('~/.vim/plugged')
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-surround'
    Plug 'int3/vim-extradite'

	if v:version >= 800
		Plug 'skywind3000/asyncrun.vim'
	endif

    Plug 'Shougo/unite.vim'
    Plug 'Shougo/neomru.vim'
    Plug 'Shougo/vimproc.vim', { 'do': 'make' }
    Plug 'Shougo/neocomplete.vim'
	Plug 'juanpabloaj/bufferWidget'

	Plug 'pangloss/vim-javascript'

    "Plug 'majutsushi/tagbar'
    Plug 'vim-syntastic/syntastic'
    Plug 'scrooloose/nerdcommenter'
    Plug 'luochen1990/rainbow'
    Plug 'elzr/vim-json'

	Plug 'johngrib/vim-git-msg-wheel'

    " On-demand loading
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

    " elixir
    Plug 'elixir-lang/vim-elixir'
	Plug 'mhinz/vim-mix-format'

	Plug 'ekalinin/Dockerfile.vim'
	Plug 'johngrib/vim-git-msg-wheel'

	Plug 'fatih/vim-go'

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	Plug 'prettier/vim-prettier', {
	  \ 'do': 'npm install',
	  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

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

" map {{{
let mapleader = ","
" spanish keyboards
ino ç <esc>
ino ¬ \
vn ç <esc>
nn ñ :
vn ñ :
nnoremap <silent><leader>ve :call NotEmptySplit() <bar>e $D/.vimrc<CR>
" <c-a> is for screen or tmux
nn <silent><c-A> <c-a>
nn <silent><leader>vS :vs $D/.vimrc<CR>
nn <silent><leader>vE :tabnew $D/.vimrc<CR>
nn <leader>vd :sp ~/.vim<CR>
nn <leader>vc :sp ~/.vim/bundle/vim-pixelmuerto/colors/pixelmuerto.vim<CR>
nn <leader>vt :exec "sp $D/.vim/templates/".&ft.".snippets.vim"<CR>
nn <leader>vcl :setl cursorline!<CR>
nn <silent><leader>s :so ~/.vimrc<CR>
nn <silent><leader>j :setl more!<bar>jumps<bar>setl more!<cr>
nn <leader>w : exec line('$') == 1 ? 'e $W' : 'sp $W'<CR>
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
nn Q gq
" format the paragraph
nn <leader>Q gqvap
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
        " en vno con yiw <c-r>0
		vno <leader>s :s//<left>
        nn <Leader>S :%s/<c-r>=expand("<cword>")<cr>//c<left><left>
	" }}}
" quick close in no modifiable files
nn <silent>q :exec !&modifiable ? ':q' : ''<CR>q
" show todolist item
nn <silent><leader>tl :vimgrep TODO\C % <CR> :copen <CR> :set nowrap <CR>
au! Filetype vim nn <leader>h :h <c-r>=expand("<cword>")<cr><cr>

set switchbuf+=usetab,newtab
nnoremap <silent><leader>g :vimgrep <cword> %:p:h/** <CR>
" }}}
" abbreviate {{{
	ia @@ jpabloaj@gmail.com
	ia @0 juanpablo <jpabloaj@gmail.com>
	ia @1 jpabloaj at gmail dot com
" }}}
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
	" elixir
	let g:mix_format_on_save = 1
	" go {{{
	let g:go_version_warning = 0
	" }}}
	" tagbar {{{
		nn <silent><Leader>l :TagbarToggle<CR>
        let tagbar_width = 30
		let tagbar_compact = 1
        "let tabbar_left = 1
		let g:tagbar_type_tex = {
	    \ 'ctagstype' : 'latex',
	    \ 'kinds'     : [
	        \ 's:sections',
	        \ 'g:graphics',
	        \ 'l:labels',
	        \ 'r:refs:1',
	        \ 'p:pagerefs:1'
	    \ ],
	    \ 'sort'    : 0
		\ }	
	" }}}
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
	nn <silent><leader>g0 :w <bar> Gsplit! diff -U0 <bar>
        \ exe BufferIsEmpty() ? "q <bar> redraw <bar> echomsg 'git: No changes'" : ''<CR> 
	nn <silent><leader>g1 :w <bar> :Gdiff HEAD~1<CR>
	nn <silent><Leader>gD <c-w>h:bd<cr>
	nn <silent><Leader>gp :Git push
	nn <silent><Leader>gP :Git push<CR><CR>
	" }}}
	" vimshell {{{
		let g:vimshell_user_prompt='substitute(getcwd(),eval("$HOME"),"~","")'
		let g:vimshell_prompt = '$ '
		nn <silent><leader>Ç :call NotEmptySplit() <bar> VimShell<cr>
		nn <silent><leader>ç :call NotEmptySplit() <bar> VimShellBufferDir<cr>
        " alias en ~/.vimshrc
		" autocmd FileType vimshell call vimshell#altercmd#define('g', 'git')
	" }}}
	" Extradite : addon for fugitive {{{
	"nnoremap <silent><leader>ge :Extradite<CR>
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
		" let g:snipMateSources['with_folding'] = funcref#Function('SnippetsWithFolding')
	" }}}
	" ultisnips {{{
		" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
		let g:UltiSnipsExpandTrigger="<tab>"
		let g:UltiSnipsJumpForwardTrigger="<c-b>"
		let g:UltiSnipsJumpBackwardTrigger="<c-z>"

		" If you want :UltiSnipsEdit to split your window.
		let g:UltiSnipsEditSplit="vertical"
	" }}}
	" Syntastic {{{
	let g:syntastic_enable_signs = 1
	"let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
	let g:syntastic_mode_map = { 'mode': 'active',
							\ 'active_filetypes': [],
							\ 'passive_filetypes': ['tex','html'] }
	let g:syntastic_cpp_compiler = 'g++'
	let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
	" }}}
	" showmarks {{{
	let g:showmarks_enable=0
	nn <silent> <leader>mo :ShowMarksOn<CR>
	nn <silent> <leader>mt :ShowMarksToggle<CR>
	"}}}
	" unite {{{
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
			nnoremap <buffer><expr> s unite#do_action('split')
			nnoremap <buffer><expr> v unite#do_action('vsplit')
			hi whitespaceEOL ctermbg=bg
		endf
		" unite-ssh
        nn <leader>us :VimFiler ssh://
		au FileType unite nnoremap <buffer><expr> s unite#do_action('split')
	" }}}
	" vimfiler {{{
        let g:vimfiler_as_default_explorer = 1
        nn <Leader>vf :VimFiler -split -horizontal <c-r>=expand("%:p:h")<cr><CR>
        nn <Leader>vF :VimFiler -split -horizontal ~<CR>
		let g:vimfiler_execute_file_list = {}
		let g:vimfiler_execute_file_list['mkd'] = 'vim'
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
    " neocomplete {{{
        let g:neocomplete#enable_at_startup = 1
    " }}}
	" BufferWidget {{{
		let g:buffer_widget_view='bars'
	" }}}
	" Ack {{{
		" you have to install ack
		nn <leader>a :Ack! <cword><CR>
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
			" RainbowParenthesesLoadRound
			" RainbowParenthesesLoadSquare
		endfunc
		" au VimEnter * RainbowParenthesesToggle
		"au FileType *.py RainbowParenthesesLoadRound
		au FileType * au Syntax * cal s:rainbow_load()
	" }}}
    " dispatch {{{
		nmap <Leader>d :Dispatch<CR>
		nmap <Leader>D :Dispatch 
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
	silent! execute '0r ~/.vim/templates/'. a:extension. '.tpl'
	silent! normal Gddgg
	silent! execute 'source ~/.vim/templates/'. a:extension. '.snippets.vim'
endfunction
function! LoadSnippets(extension)
    let filename = expand("~/.vim/templates/"). expand(a:extension) .".snippets.vim"
	if filereadable(filename)
	    silent! execute 'source '.filename
	endif
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

colorscheme gruvbox | set background=dark
""}}}
" highlight {{{
	highlight whitespaceEOL term=reverse ctermbg=Grey guibg=Grey
	au Syntax * syn match whitespaceEOL /\s\+\(\%#\)\@!$/ containedin=ALL
	" don't show whitespaceEOL in unite ft
	au Filetype unite,vimshell,tlibInputList,qf hi whitespaceEOL ctermbg=bg
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
	
	augroup vimrc
		autocmd QuickFixCmdPost * botright copen 8
	augroup END

	" limpiar la terminal al salir de vim
	"autocmd VimLeave * !clear
	" When vimrc is edited, reload it
	au! CmdwinEnter * nn <silent><buffer> q :q<CR>
	autocmd! bufwritepost .vimrc source ~/.vimrc

	if v:version > 704
	augroup longLines
		au!
		au! filetype zsh,sh,vim
			\ syn match ColorColumn /\%>80v.\+/
	augroup END
	endif
	" never mix tabs and spaces
	au FileType vim,python if search('^\t') >0 |
		\ exe "setl noexpandtab" |
		\ endif
	" Restore cursor position
	autocmd BufReadPost *
	  \ if line("'\"") > 1 && line("'\"") <= line("$") |
	  \   exe "normal! g`\"" |
	  \ endif
	autocmd InsertEnter * hi statusline ctermfg=255
	autocmd InsertLeave * hi statusline ctermfg=250
	autocmd BufNewFile,BufRead *.json set ft=javascript
	autocmd FileType javascript setlocal sw=2 ts=2 sts=2
	autocmd FileType cpp setlocal sw=2 ts=2 sts=2
	autocmd FileType jade setlocal sw=2 ts=2 sts=2
	au FileType qf call AdjustWindowHeight(3, 10)
	function! AdjustWindowHeight(minheight, maxheight)
        let l = 1
        let n_lines = 0
        let w_width = winwidth(0)
        while l <= line('$')
            " number to float for division
            let l_len = strlen(getline(l)) + 0.0
            let line_width = l_len/w_width
            let n_lines += float2nr(ceil(line_width))
            let l += 1
        endw
	    exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
	endfunction
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
fun! BufferIsEmpty() "{{{
	if line('$') == 1 && getline(1) == ''
		return 1
	else
		return 0
	endif
endf "}}}
fun! NotEmptySplit() "{{{
	if !BufferIsEmpty()
	    exec 'sp'
	endif
endf
"}}}
