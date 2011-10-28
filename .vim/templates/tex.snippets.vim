" por defecto es {{{,}}} cambiado para ajustarse a snipmate
setl fdm=marker
setl foldmarker=(fold),(end)
setl wrap
setl ft=tex
" para guardar y compilar el tex actual
nn ,m :w <BAR> !pdflatex %<CR>
