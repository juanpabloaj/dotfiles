fun! Make() "{{{
    if filereadable('Makefile')
        setlocal makeprg=make
    else
        setlocal makeprg=python\ %
    endif
endf "}}}
call Make()
" guardar y ejecutar
nn ,m :update<CR>:call Make()<CR>:Make<CR><space>
" abbreviate
" don't use <space> use 
" with s. self.
"ia <buffer>s self
"ia <buffer>p print
" after header #!..
normal G
