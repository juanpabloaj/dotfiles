rcFiles =  .vim .vimrc .gitconfig .hgrc .screenrc .Xresources .dircolors .bashrc .ctags .bash_completion.d 
LOCAL=$(PWD)
install: 
	git submodule init
	git submodule update
	mkdir -p .vim/autoload
	@[ -f $(PWD)/.vim/autoload/pathogen.vim ] || ln -v -s $(PWD)/.vim/bundle/vim-pathogen/autoload/pathogen.vim $(PWD)/.vim/autoload/
	cd $(PWD)/utils/git-prompt; make install
	-cd utils/git-prompt ; git remote add lvv git://github.com/lvv/git-prompt.git
	-cd .vim/bundle/snipmate-snippets ; git remote add honza https://github.com/honza/snipmate-snippets.git
	-cd .vim/bundle/vim-snipmate ; git remote add garbas https://github.com/garbas/vim-snipmate.git
	mkdir -p .bash_completion.d
	cd .bash_completion.d ; [ -e git-completion.bash ] || wget -c http://repo.or.cz/w/git.git/blob_plain/HEAD:/contrib/completion/git-completion.bash
	@$(foreach f,$(rcFiles), [ -e $(HOME)/$f ] || ln -s -fvn  $(PWD)/$f $(HOME)/ ;  )
clean:
	$(foreach f,$(vimFiles),unlink $(f);)
	cd $(PWD)/utils/git-prompt; make clean
	$(foreach f,$(rcFiles), [ -L $(HOME)/$f ] && unlink $(HOME)/$f;)
