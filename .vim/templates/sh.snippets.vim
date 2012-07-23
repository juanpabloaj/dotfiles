" automatically give executable permissions if file begins with #! and contains '/bin/' in the path
function ModeChange()
    if expand("<afile>") =~ "^scp"
        return
    endif
  if getline(1) =~ "^#!"
    if getline(1) =~ "/bin/"
      silent !chmod a+x <afile>
    endif
  endif
endfunction
au BufWritePost * call ModeChange()
nn ,m :w <BAR> !bash %<CR>
