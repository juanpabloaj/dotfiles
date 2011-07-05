rcFiles =  .vim .vimrc .gitconfig .hgrc .screenrc .Xresources .dircolors .bashrc .ctags .bash_completion.d 
install: 
	git submodule init
	git submodule update
	mkdir -p .vim/autoload
	@[ -f $(PWD)/.vim/autoload/pathogen.vim ] || ln -v -s $(PWD)/.vim/bundle/vim-pathogen/autoload/pathogen.vim $(PWD)/.vim/autoload/
	@$(foreach f,$(rcFiles), [ -f $(HOME)/$f ] || ln -v -s $(PWD)/$f $(HOME)/ ;  )
clean:
	$(foreach f,$(vimFiles),unlink $(f);)
	$(foreach f,$(rcFiles), [ -L $(HOME)/$f ] && unlink $(HOME)/$f;)
