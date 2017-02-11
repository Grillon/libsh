#!/usr/bin/env bash
. libError.sh
#if [ $# -ne 1 ];then
	#echo "veuillez fournir un nom de fichier sh contenant du pod en argument"
	#exit 1
#elif [ "${1#*.*sh}" != "" ];then
	#echo "je n'accepte que les fichiers .bash .ksh .sh en argument pour le moment"
	#exit 2
#fi
for file in *.*sh
do
	destination=docs/${file%.sh}{.pod,.html,.man}
	./extract_pod.sh $file > docs/${file%.sh}.pod
	erreur $? "conversioni $file" "rm $destination"
	pod2html $file > docs/${file%.sh}.html
	pod2man $file > docs/${file%.sh}.man
done
