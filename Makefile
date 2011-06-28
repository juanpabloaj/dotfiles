# TODO add make install 
vimFiles = $(shell find .vim -type l)
rcFiles =  .vim .vimrc .gitconfig .hgrc .screenrc .Xresources .dircolors .bashrc .ctags .bash_completion.d .git-prompt.conf
clean:
	$(foreach f,$(vimFiles),unlink $(f);)
	$(foreach f,$(rcFiles), [ -L $(HOME)/$(f) ] && unlink $(HOME)/$(f);)
