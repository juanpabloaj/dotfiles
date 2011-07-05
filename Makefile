rcFiles =  .vim .vimrc .gitconfig .hgrc .screenrc .Xresources .dircolors .bashrc .ctags .bash_completion.d 
LOCAL=$(PWD)
install: 
	git submodule init
	git submodule update
	mkdir -p .vim/autoload
	@[ -f $(PWD)/.vim/autoload/pathogen.vim ] || ln -v -s $(PWD)/.vim/bundle/vim-pathogen/autoload/pathogen.vim $(PWD)/.vim/autoload/
	cd $(PWD)/utils/git-prompt; make install
	@$(foreach f,$(rcFiles), [ -e $(HOME)/$f ] || ln -s -fvn  $(PWD)/$f $(HOME)/ ;  )
clean:
	$(foreach f,$(vimFiles),unlink $(f);)
	cd $(PWD)/utils/git-prompt; make clean
	$(foreach f,$(rcFiles), [ -L $(HOME)/$f ] && unlink $(HOME)/$f;)
