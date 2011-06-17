#!/bin/bash
# Algunas variables utiles {{{ 
dirLocal=$PWD
dirPadre=${PWD%/*}
# }}}
#{{{ ln -s a los archivos de configuracion 
## agregar algunos ifs para relinkear cuando sea necesario
## .bashrc bin .config .dircolors .git .gitconfig .gitignore .hgrc README .screenrc .vim .vimrc .Xresources 
archivosRc=( .vim .vimrc .gitconfig .hgrc .screenrc .Xresources .dircolors .bashrc .ctags)
for a in ${archivosRc[@]}
do
	if [ -e $HOME/$a ]
	then 
		echo "$HOME/$a ya existe!"
	else
		if [ -e $a ]
		then
		ln -s -v $dirLocal/$a $HOME
		#echo "ln -s $a $HOME"
		#echo "Linkeado el directorio $a al $HOME"
		fi 
	fi
done
# }}}
# Clonado de plugins de vim {{{
## pensar si es las conveniente agregar archivos al gitignore y solo sean ubicados a traves de este script
# http://github.com/msanders/snipmate.vim.git
# http://github.com/ervandew/supertab.git
cd .vim
dirs=(after autoload ftplugin syntax plugin snippets)
for d in ${dirs[@]}
do 
	if [ ! -d $d ]
	then 
		mkdir $dirLocal/.vim/$d 
		echo "mkdir $dirLocal/.vim/$d"
		echo "Directorio $dirLocal/.vim/$d creado"
	fi
done
echo "Creando directorios necesarios para vim"
cd $dirLocal
repos=( tpope/vim-fugitive.git vim-scripts/taglist.vim.git juanpabloaj/absolutFold.git MarcWeber/vim-addon-mw-utils.git tomtom/tlib_vim.git garbas/vim-snipmate.git ervandew/supertab.git vim-scripts/xoria256.vim.git vim-scripts/mayansmoke.git pixelmuerto/vim-pixelmuerto.git hallison/vim-markdown.git Shougo/vimshell.git Shougo/vimproc.git scrooloose/nerdtree.git )
for repo in ${repos[@]}
do
	#echo "http://github.com/$repo"
	repoDirName=${repo#*/}
	repoDirName=${repoDirName%.*}
	if [ ! -d ../$repoDirName ]
	then 
		echo "Clonando $repoDirName"
		r=git://github.com/$repo
		cd ..
		echo "git clone $r"
		git clone $r #>& /dev/null
		echo 
		cd $dirLocal 
	fi
	if [ -d ../$repoDirName ]
	then 
		echo 
		echo "cd $dirPadre/$repoDirName"
		cd ../$repoDirName
		echo "git pull "$repoDirName
		git pull
		vimDir="$HOME/.vim"
		vimDirContent=$(find $vimDir -maxdepth 1 -type d )
		pluginContent=$(find . -maxdepth 1 -type d )
		for pContent in $pluginContent
		do 
			pContent=${pContent#*/}
			if [[ "$pContent" != ".git" && "$pContent" != "." ]]
			then
				pContentToMove=$vimDir/$pContent
				if [ ! -e $pContentToMove ] 
				then 
					ln -v -s $PWD/$pContent $vimDir
					
				else
					if [ -h $pContentToMove ] 
					then 
						unlink $pContentToMove 	
						ln -s -v $PWD/$pContent $pContentToMove 
						
					else
						for c in $(ls $pContent)
						do
							if [[ -e $pContentToMove/$c || -h $pContentToMove/$c ]]
							then
								if [[ -h $pContentToMove/$c  ]]
								then 
									unlink $pContentToMove/$c
									ln -s -v $PWD/$pContent/$c $pContentToMove/$c 
									
								else
									echo "$pContentToMove/$c ya existe!"
								fi 
							else
								ln -s -v $PWD/$pContent/$c $pContentToMove/$c 
								
							fi
						done
					fi
				fi
			fi
		done
		cd $dirLocal 
		echo
		echo "cd $dirLocal"
	else 
		echo "No se clono correctamente $r"
	fi
done
# }}}
# vim spell {{{
echo "cd $dirLocal/.vim/spell"
cd $dirLocal/.vim/spell 
bash spell.sh
cd $dirLocal 
echo "cd $dirLocal"
# }}}
# bash completions {{{
if [ ! -d .bash_completion.d ]
then 
	mkdir .bash_completion.d
	echo "mkdir .bash_completion.d"
	echo "Directorio $dirLocal/.bash_completion.d creado"
fi 
if [ ! -d $HOME/.bash_completion.d ]
then 
	ln -s -v $dirLocal/.bash_completion.d $HOME
	
fi 
if [ ! -e .bash_completion.d/git-completion.bash ]
then 
	cd .bash_completion.d 
	echo "cd .bash_completion.d"
	echo "Descargando git-completion"
	echo "wget -c http://repo.or.cz/w/git.git/blob_plain/HEAD:/contrib/completion/git-completion.bash"
	wget -c http://repo.or.cz/w/git.git/blob_plain/HEAD:/contrib/completion/git-completion.bash
fi
cd $dirLocal 
echo "cd $dirLocal"
# }}}
