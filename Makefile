vimFiles = .vim .vimrc
rcFiles = .gitconfig .hgrc .screenrc .Xresources .dircolors .bashrc .bash_profile .ctags .bash_completion.d .zshrc .aliases .gitexcludes .vimshrc .tmux.conf
LOCAL=$(PWD)
UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
	VIMPROCMAKE = make_gcc.mak
endif
ifeq ($(UNAME), Darwin)
	VIMPROCMAKE = make_mac.mak
endif
ifeq ($(UNAME), CYGWIN_NT-6.1)
	VIMPROCMAKE = make_cygwin.mak
endif
relink:
	@$(foreach f,$(rcFiles), [ -e $(HOME)/$f ] || ln -s -fvn  $(PWD)/$f $(HOME)/ ;  )
	cd utils/git-map ; ln -v -s -f $(PWD)/utils/git-map/git-map $(HOME)/opt/bin/
	cd utils/git-remote-init ; ln -v -s -f $(PWD)/utils/git-remote-init/bin/* $(HOME)/opt/bin/
	cd utils/oh-my-zsh ; [ -d $(HOME)/.oh-my-zsh ] || ln -vf -s $(PWD)/utils/oh-my-zsh $(HOME)/.oh-my-zsh

install: viminstall
	git submodule init
	git submodule update
	@[ -d $(HOME)/opt/bin ] || mkdir -vp $(HOME)/opt/bin
	@$(foreach f,$(rcFiles), [ -e $(HOME)/$f ] || ln -s -fvn  $(PWD)/$f $(HOME)/ ;  )
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
	git submodule foreach git pull
fetch:
	git submodule foreach git fetch

neovim:
	@echo "Copiando archivos de configuracion a "$(HOME)/.config
	ln -s $(PWD)/.config/nvim $(HOME)/.config
	pip3 install neovim

viminstall: vimdirs linkVimFiles vimplug vimspell

linkVimFiles:
	@$(foreach f,$(vimFiles), [ -e $(HOME)/$f ] || ln -s -fvn  $(PWD)/$f $(HOME)/ ;  )

vimspell:
	cd .vim/spell; bash spell.sh

vimproc:
	cd $(PWD)/.vim/bundle/vimproc ; make -f $(VIMPROCMAKE) clean && make -f $(VIMPROCMAKE)

vimplug:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qa

vimdirs:
	mkdir -p .vim/autoload
	mkdir -p .vim/tmp/undo
	mkdir -p .vim/tmp/backup
	mkdir -p .vim/tmp/swap

pyenv:
	curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

gitBashPrompt:
	cd ~ && git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1
	@echo "GIT_PROMPT_ONLY_IN_REPO=1"
	@echo "source ~/.bash-git-prompt/gitprompt.sh"

gitCompile:
	mkdir -p ~/opt/src
	cd ~/opt/src && wget https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.gz
	cd ~/opt/src && tar xfz git-*.tar.gz
	cd ~/opt/src/git-* && make configure && ./configure --prefix=$(HOME)/opt
	cd ~/opt/src/git-* && make && make install

gitBashCompletion:
	mkdir -p .bash_completion.d
	cd .bash_completion.d ; [ -e git-completion.bash ] || wget -c http://repo.or.cz/w/git.git/blob_plain/HEAD:/contrib/completion/git-completion.bash
	ln -s $(PWD)/.bash_completion.d ~/.bash_completion.d
	@echo
	@echo "Add to ~/.bashrc"
	@echo "if [ -d $$HOME/.bash_completion.d/ ]; then"
	@echo "  . $$HOME/.bash_completion.d/*"
	@echo "fi"
