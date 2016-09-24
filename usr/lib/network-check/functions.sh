#!/bin/sh

# get all interfaces
interfaces () {
    ifconfig | perl -ne 'if (s/^(\w+)\s+Link encap:.*$/$1/ and not m/^lo/) { print }'
    }   

# wireless interfaces
interfaces_wireless () {
    iwconfig 2>/dev/null | perl -ne 'print if s/^(\w+)\s+.*$/$1/'
    }

# check if cable is connected
cable_connected () {
    ethtool "$1" 2>/dev/null | grep -E '^\s*Link detected:\s*yes\s*$' >/dev/null
    }
