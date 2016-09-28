#!/bin/sh

# define colors
# taken from demure's post on http://stackoverflow.com/questions/16843382/colored-shell-script-output-library#16844327
RCol='\033[0m'   # Text Reset

# Regular          
Bla='\033[0;30m';  
Red='\033[0;31m';  
Gre='\033[0;32m';  
Yel='\033[0;33m';  
Blu='\033[0;34m';  
Pur='\033[0;35m';  
Cya='\033[0;36m';  
Whi='\033[0;37m';  

bold=$(tput bold)
normal=$(tput sgr0)


# message functions
info () {
    echo "[ ${bold}${Whi}INFO${RCol} ] $1"
    }
ok () {
    echo "[   ${bold}${Gre}OK${RCol} ] $1"
    }
warn () {
    echo "[ ${bold}${Yel}WARN${RCol} ] $1"
    }
crit () {
    echo "[ ${bold}${Red}CRIT${RCol} ] $1"
    }

bold () {
    echo "${bold}$1${normal}"
}

# prefix every line with something
indent () {
    if test -z "$1";
    then PRE="    "
    else PRE=$1
    fi
    perl -pe "s|^|$PRE|"
    }

# get all interfaces
interfaces () {
    ifconfig | perl -ne 'if (s/^(\w+)\s+Link encap:.*$/$1/ and not m/^lo/) { print }'
    }   

# wireless interfaces
interfaces_wireless () {
    iwconfig 2>/dev/null | perl -ne 'print if s/^(\w+)\s+.*$/$1/'
    }

# check if this interface is wireless
interface_is_wireless () {
    interfaces_wireless | grep -q "$1"
    }

# check if cable is connected
physical_connection () {
    ethtool "$1" 2>/dev/null | grep -qE '^\s*Link detected:\s*yes\s*$'
    }

# determine router ip
router_ip () {
    ip route | perl -ne 'print m/default.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/'
}

# determine router url
get_hostname_from_ip () {
    host $1 | perl -e 'print grep {m/\./} m/pointer\s+(.*)\.$/ while(<>)'
}
