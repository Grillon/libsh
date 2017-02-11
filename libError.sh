#!/usr/bin/env bash
#variable
OK=0;
KO=1;
ECONT=1;
ESTOP=251;

#commandes
cAwk=${cAwk:=awk}

#titre fonction plus arg1
HEADER="typeset maFonction=\"\${aGras}\${0}\${dGras} -\";typeset mf=\"\${maFonction}(\$1)\"";

#HEADERS
#= verification du nombre d'arguments
#if [ $# -ne 1 ];then erreur $KO "$0 : nombre d'argument incorrects" $ECONT;fi
#= initialisation du debug level
#$MODE_DEBUG

#= titre de la fonction
#typeset maFonction="${aGras}${0}${dGras} -";
#= sous ensemble de la fonction
#typeset mf="${maFonction}($1)"
#- cela peut être remplacé par eval $HEADER


function debug
{
eval $HEADER
if [ $# -ne 1 ];then erreur $KO "$0 : nombre d'argument incorrects" $ECONT;fi
case $1 in
0) MODE_DEBUG=""
	;;
1)	MODE_DEBUG="set -x"
	;;
2)	MODE_DEBUG="set -xv"
	;;
*)	erreur $KO "$0 : argument $1 invalides" $ECONT
	MODE_DEBUG="set -xv"
	return 1
	;;
esac
return 0
}
function erreur
{
$MODE_DEBUG
eval $HEADER
#erreur devient complexe
#arg 1 : numero d'erreur;
#arg 2 : message;
#arg 3 : code erreur(de 251 ` 254), $ECONT pour continuer, $ESTOP pour arret;
#args 4 : fonction ` appeller en cas d'erreur avant sortie

typeset codeRetourE=$1
typeset message=$2
typeset codeRetourS=$3
typeset date=$(date "+%m%d %H:%M")

if [ $codeRetourE -ne 0 ];then
	echo "${aGras} $(uname -n) ${dGras} - $date - : ${tRouge} $message ${fRouge}${tBlanc} KO ${raz}" >&2
	if [ -n "$4" ];then
		typeset action=$4
		eval $action
		ERREUR=$?
	fi
	if [ $codeRetourS -ge 251 ];then
		exit $codeRetourS
	fi
	return $codeRetourE;
else
echo "${aGras} $(uname -n) ${dGras}  - $date - : ${tVert} $message ${fVert}${tNoir} OK ${raz}"
return $OK;
fi
}
libError=1;
