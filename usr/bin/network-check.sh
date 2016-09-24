#!/bin/sh

# read functions
. $(dirname $0)/../lib/network-check/functions.sh

# define colors
# taken from demure's post on http://stackoverflow.com/questions/16843382/colored-shell-script-output-library#16844327
RCol='\033[0m'   # Text Reset

# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\033[0;30m';     BBla='\033[1;30m';    UBla='\033[4;30m';    IBla='\033[0;90m';    BIBla='\033[1;90m';   On_Bla='\033[40m';    On_IBla='\033[0;100m';
Red='\033[0;31m';     BRed='\033[1;31m';    URed='\033[4;31m';    IRed='\033[0;91m';    BIRed='\033[1;91m';   On_Red='\033[41m';    On_IRed='\033[0;101m';
Gre='\033[0;32m';     BGre='\033[1;32m';    UGre='\033[4;32m';    IGre='\033[0;92m';    BIGre='\033[1;92m';   On_Gre='\033[42m';    On_IGre='\033[0;102m';
Yel='\033[0;33m';     BYel='\033[1;33m';    UYel='\033[4;33m';    IYel='\033[0;93m';    BIYel='\033[1;93m';   On_Yel='\033[43m';    On_IYel='\033[0;103m';
Blu='\033[0;34m';     BBlu='\033[1;34m';    UBlu='\033[4;34m';    IBlu='\033[0;94m';    BIBlu='\033[1;94m';   On_Blu='\033[44m';    On_IBlu='\033[0;104m';
Pur='\033[0;35m';     BPur='\033[1;35m';    UPur='\033[4;35m';    IPur='\033[0;95m';    BIPur='\033[1;95m';   On_Pur='\033[45m';    On_IPur='\033[0;105m';
Cya='\033[0;36m';     BCya='\033[1;36m';    UCya='\033[4;36m';    ICya='\033[0;96m';    BICya='\033[1;96m';   On_Cya='\033[46m';    On_ICya='\033[0;106m';
Whi='\033[0;37m';     BWhi='\033[1;37m';    UWhi='\033[4;37m';    IWhi='\033[0;97m';    BIWhi='\033[1;97m';   On_Whi='\033[47m';    On_IWhi='\033[0;107m';

bold=$(tput bold)
normal=$(tput sgr0)


ok () {
    echo "[   ${bold}${Gre}OK${RCol} ] $1"
    }
warn () {
    echo "[ ${bold}${Yel}WARN${RCol} ] $1"
    }
error () {
    echo "[  ${bold}${Yel}ERR${RCol} ] $1"
    }

# prefix every line with something
indent () {
    if test -z "$1";
    then PRE="    "
    else PRE=$1
    fi
    perl -pe "s|^|$PRE|"
    }


cat <<EOT
*****************************************
***   This is ${bold}network-check${normal} v0.0.1    ***
***   latest revision: 24.09.2016 by  ***
*** Yann Büchau (yann.buechau@web.de) ***
*****************************************
EOT

# get interfaces
INTERFACES=$(interfaces)

echo
echo "There are the interfaces:"
for INTERFACE in $INTERFACES;do
    echo "${bold}$INTERFACE${normal}"
done

echo
cat <<EOT
**********************
*** ${bold}physical check${normal} ***
**********************
EOT

for INTERFACE in $INTERFACES;do
    if cable_connected $INTERFACE;then
        ok "There is a physical connection on interface ${bold}$INTERFACE${normal}."
    else
        warn "There is no physical connection on interface $INTERFACE."
    fi
done
