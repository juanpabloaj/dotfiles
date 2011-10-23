" por defecto es {{{,}}} cambiado para ajustarse a snipmate
setl fdm=marker
setl foldmarker=(fold),(end)
setl wrap
" para guardar y compilar el tex actual
nn ,m :w <BAR> !pdflatex %<CR>
