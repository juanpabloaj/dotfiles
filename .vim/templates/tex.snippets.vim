" por defecto es {{{,}}} cambiado para ajustarse a snipmate
set fdm=marker
set foldmarker=(fold),(end)
set wrap
" para guardar y compilar el tex actual
nn ,m :w <BAR> !pdflatex %<CR>
