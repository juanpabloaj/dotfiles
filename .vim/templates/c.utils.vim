setlocal fdm=syntax
nn ,m :w <bar> make<CR>
" for # in pragma openmp sentences
setl cinkeys-=0#
