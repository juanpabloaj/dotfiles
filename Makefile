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

install: vimInstall
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

vimCompileCentos6:
	sudo yum install -y gcc-c++ ncurses-devel python-devel git
	$(eval tempDir := $(shell mktemp -d))
	mkdir -p $(HOME)/.local
	cd $(tempDir) && git clone https://github.com/vim/vim.git
	cd $(tempDir)/vim/src && git checkout $(shell git tag | tail -1)
	cd $(tempDir)/vim/src && ./configure \
	--disable-nls \
	--enable-cscope \
	--enable-gui=no \
	--enable-multibyte  \
	--enable-pythoninterp \
	--enable-rubyinterp \
	--prefix=$(HOME)/.local/vim \
	--with-features=huge  \
	--with-python-config-dir=/usr/lib/python2.6/config \
	--with-tlib=tinfo \
	--without-x
	cd $(tempDir)/vim/src && make && make install
	echo "" >> ~/.bashrc
	echo "if [ -d "\$$HOME/.local/vim/bin/" ] ; then" >> ~/.bashrc
	echo "    export PATH="\$$HOME/.local/vim/bin/:\$$PATH"" >> ~/.bashrc
	echo "fi" >> ~/.bashrc

vimInstall: vimdirs linkVimFiles vimplug vimspell

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

nvm:
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

nodejs: nvm
	source ~/.bashrc && nvm install v8.11.2


fullInstall: quickInstall pyenv nvm

quickInstall: vimInstall gitBash copyFiles toBashrc gitAddUser

copyFiles:
	[ -e ~/.gitconfig ] || cp -v $(PWD)/.gitconfig ~/.gitconfig

gitBash: gitBashPrompt gitBashCompletion gitFlow toBashrc

gitFlow:
	mkdir -p $(HOME)/src
	cd $(HOME)/src && git clone --recursive git://github.com/nvie/gitflow.git
	cd $(HOME)/src/gitflow && make prefix=$(HOME)/opt install

gitBashPrompt:
	[ -e ~/.bash-git-prompt ] || git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
	@echo "GIT_PROMPT_ONLY_IN_REPO=1"
	@echo "source ~/.bash-git-prompt/gitprompt.sh"

gitCompile:
	mkdir -p ~/opt/src
	cd ~/opt/src && wget https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.gz
	cd ~/opt/src && tar xfz git-*.tar.gz
	cd ~/opt/src/git-* && make configure && ./configure --prefix=$(HOME)/opt
	cd ~/opt/src/git-* && make && make install

gitBashCompletion:
	$(eval gitVersion := $(shell git --version | awk '{print $$NF}'))
	mkdir -p .bash_completion.d
	cd .bash_completion.d ; [ -e git-completion.bash ] || wget -c https://raw.githubusercontent.com/git/git/v$(gitVersion)/contrib/completion/git-completion.bash
	cd .bash_completion.d ; [ -e git-flow-completion.bash ] || wget -c https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.bash
	cd .bash_completion.d ; [ -e docker ] || curl -L https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker > docker
	cd .bash_completion.d ; [ -e docker-compose ] || curl -L https://raw.githubusercontent.com/docker/compose/1.16.1/contrib/completion/bash/docker-compose -o docker-compose
	[ -e ~/.bash_completion.d ] || ln -s $(PWD)/.bash_completion.d ~/.bash_completion.d
	@echo
	@echo "Add to ~/.bashrc"
	@echo "if [ -d \$$HOME/.bash_completion.d/ ]; then"
	@echo "    for f in \$$HOME/.bash_completion.d/*; do source \$$f; done"
	@echo "fi"

toBashrc:
	@echo "Adding to ~/.bashrc"
	echo "" >> ~/.bashrc
	echo "export EDITOR=vi" >> ~/.bashrc
	echo "set -o vi" >> ~/.bashrc
	echo "" >> ~/.bashrc
	echo "if [ -d \$$HOME/.bash_completion.d/ ]; then" >> ~/.bashrc
	echo "    for f in \$$HOME/.bash_completion.d/*; do source \$$f; done" >> ~/.bashrc
	echo "fi" >> ~/.bashrc
	echo "" >> ~/.bashrc
	echo "export PATH=\$$HOME/opt/bin:\$$PATH" >> ~/.bashrc
	echo "" >> ~/.bashrc
	echo "GIT_PROMPT_ONLY_IN_REPO=1" >> ~/.bashrc
	echo "source ~/.bash-git-prompt/gitprompt.sh" >> ~/.bashrc

gitAddUser:
	git config user.name "JuanPablo"
	git config user.email jpabloaj@gmail.com

gitEraseFromCentos:
	sudo yum erase -y git

gitUpdateCentos: gitEraseFromCentos
	$(eval centosVersion := $(shell sed 's/\.[0-9]//' /etc/centos-release | awk '{print $$3}' ))
	$(eval tempDir := $(shell mktemp -d))
	$(eval gitRpm := git214-2.14.0-0.1.ius.el$(centosVersion).x86_64.rpm )
	$(eval perlRpm := perl-Git214-2.14.0-0.1.ius.el$(centosVersion).noarch.rpm )
	cd $(tempDir) && \
		wget https://github.com/juanpabloaj/git-rpm-centos/releases/download/2.14.0/$(gitRpm) && \
		wget https://github.com/juanpabloaj/git-rpm-centos/releases/download/2.14.0/$(perlRpm)
	cd $(tempDir) && sudo yum install -y $(gitRpm) $(perlRpm)

dockerComposeInstall:
	mkdir -p $(HOME)/opt/bin
	curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o $(HOME)/opt/bin/docker-compose
	chmod u+x $(HOME)/opt/bin/docker-compose

goInstall:
	cd /tmp && wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
	cd /tmp && tar -C $(HOME)/opt -xzf go1.10.1.linux-amd64.tar.gz
	@echo "add to ~/.bashrc"
	@echo
	@echo "export PATH=\$$PATH:\$$HOME/opt/go/bin"

oklogInstall:
	wget https://github.com/oklog/oklog/releases/download/v0.3.2/oklog-0.3.2-linux-amd64 -O $(HOME)/opt/bin/oklog && chmod u+x $(HOME)/opt/bin/oklog
