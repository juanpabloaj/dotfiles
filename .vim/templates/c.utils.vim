setlocal fdm=syntax
nn <silent><leader>m :w <bar> make<CR>:call CleanCopen()<CR>
" for # in pragma openmp sentences
setl cinkeys-=0#

fun! CleanCopen() "{{{
    let n = len(getqflist())
    if get(get(getqflist(), 0, {}), 'text', '') !~# 'Nothing to be done' && n > 1
        sil exec 'copen'
        sil exec 'resize '.n
    endif
endf "}}}
