rcFiles =  .vim .vimrc .gitconfig .hgrc .screenrc .Xresources .dircolors .bashrc .ctags .bash_completion.d .zshrc .aliases .gitexcludes
LOCAL=$(PWD)
relink:
	@[ -f $(PWD)/.vim/autoload/pathogen.vim ] || ln -vfs $(PWD)/.vim/bundle/vim-pathogen/autoload/pathogen.vim $(PWD)/.vim/autoload/
	@$(foreach f,$(rcFiles), [ -e $(HOME)/$f ] || ln -s -fvn  $(PWD)/$f $(HOME)/ ;  )
	cd utils/git-map ; ln -v -s -f $(PWD)/utils/git-map/git-map $(HOME)/opt/bin/
	cd utils/git-remote-init ; ln -v -s -f $(PWD)/utils/git-remote-init/bin/* $(HOME)/opt/bin/
	cd utils/oh-my-zsh ; [ -d $(HOME)/.oh-my-zsh ] || ln -vf -s $(PWD)/utils/oh-my-zsh $(HOME)/.oh-my-zsh
install:
	git submodule init
	git submodule update
	@[ -d $(HOME)/opt/bin ] || mkdir -vp $(HOME)/opt/bin
	mkdir -p .vim/autoload
	mkdir -p .vim/tmp/undo
	mkdir -p .vim/tmp/backup
	mkdir -p .vim/tmp/swap
	@[ -f $(PWD)/.vim/autoload/pathogen.vim ] || ln -v -s $(PWD)/.vim/bundle/vim-pathogen/autoload/pathogen.vim $(PWD)/.vim/autoload/
	cd $(PWD)/utils/git-prompt; make install
	mkdir -p .bash_completion.d
	cd .bash_completion.d ; [ -e git-completion.bash ] || wget -c http://repo.or.cz/w/git.git/blob_plain/HEAD:/contrib/completion/git-completion.bash
	@$(foreach f,$(rcFiles), [ -e $(HOME)/$f ] || ln -s -fvn  $(PWD)/$f $(HOME)/ ;  )
	cd .vim/spell; bash spell.sh
	cd utils/git-map ; ln -v -s -f $(PWD)/utils/git-map/git-map $(HOME)/opt/bin/
	cd utils/git-remote-init ; ln -v -s -f $(PWD)/utils/git-remote-init/bin/* $(HOME)/opt/bin/
	cd utils/oh-my-zsh ; [ -d $(HOME)/.oh-my-zsh ] || ln -vf -s $(PWD)/utils/oh-my-zsh $(HOME)/.oh-my-zsh
	# TODO install rvm and ruby
	# TODO if installed then update : git submodule, etc
clean:
	$(foreach f,$(vimFiles),unlink $(f);)
	cd $(PWD)/utils/git-prompt; make clean
	$(foreach f,$(rcFiles), [ -L $(HOME)/$f ] && unlink $(HOME)/$f;)
	cd $(HOME)/opt/bin ; [ -h git-map ] && unlink git-map
	cd $(HOME) ; [ -h .oh-my-zsh ] &&  unlink .oh-my-zsh
pull:
	cd $(PWD)/.vim/bundle/vim-pathogen ; git map co master ; git map pull
