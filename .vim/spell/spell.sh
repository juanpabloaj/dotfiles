#!/bin/bash
## para descargar diccionario de ortografia

[ ! -d $HOME/.vim/spell ] && echo "directory $HOME/.vim/spell not found" && exit 1

pushd $HOME/.vim/spell

leng="es en"
for l in $leng
do
	lenguaje=$l".utf-8"
	l0=$lenguaje".sug"
	if [ ! -e $l0 ]
	then
		echo "Descargando $l0"
		wget -c https://ftp.nluug.nl/pub/vim/runtime/spell/$l0
	else 
		echo "Ya existe $l0"
	fi 
	l1=$lenguaje".spl"
	if [ ! -e $l1 ]
	then
		echo "Descargando $l1"
		wget -c https://ftp.nluug.nl/pub/vim/runtime/spell/$l1
	else
		echo "Ya existe $l1"
	fi 
done
#wget -c http://ftp.vim.org/pub/vim/runtime/spell/es.utf-8.sug
#wget -c http://ftp.vim.org/pub/vim/runtime/spell/es.utf-8.spl

popd
