" por defecto es {{{,}}} cambiado para ajustarse a snipmate
setl fdm=marker
setl foldmarker=(fold),(end)
setl wrap
setl ft=tex
" para guardar y compilar el tex actual
nn ,m :w <BAR> !pdflatex %<CR>
nn ,M :w <BAR> !pdflatex % ; bibtex %:t:r ; pdflatex % ; pdflatex %<CR>
" [A-Z] to $[A-Z]$
for ch in range(char2nr("A"),char2nr("Z"))
	execute "ia <buffer>".nr2char(ch)." $".nr2char(ch)."$"
endfor
