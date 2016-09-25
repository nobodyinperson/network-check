#!/usr/bin/perl6
use v6;

unit module NetworkCheck;

our %TERMCOLOURS is export  =
    normal  => "\e[0m",
    bold    => "\e[1m",
    black   => "\e[30m",bblack  => "\e[1m\e[30m",
    red     => "\e[31m",bred    => "\e[1m\e[31m",
    green   => "\e[32m",bgreen  => "\e[1m\e[32m",
    yellow  => "\e[33m",byellow => "\e[1m\e[33m",
    blue    => "\e[34m",bblue   => "\e[1m\e[34m",
    magenta => "\e[35m",bmagenta=> "\e[1m\e[35m",
    cyan    => "\e[36m",bcyan   => "\e[1m\e[36m",
    white   => "\e[37m",bwhite  => "\e[1m\e[37m",
    ;

our sub coloured 
    (Str $colour, Str $text, Bool :$reset=True) is export returns Str {
    my $end = ""; $end = %TERMCOLOURS<normal> if $reset;
    %TERMCOLOURS{$colour}~$text~$end
    }

our sub message_ok (Str $text) is export {
    say sprintf('[ '~coloured('green','%4s')~' ] ','OK') ~ $text
    }

our sub message_problem (Str $text) is export {
    say sprintf('[ '~coloured('yellow','%4s')~' ] ','PROB') ~ $text
    }

our sub message_critical (Str $text) is export {
    say sprintf('[ '~coloured('red','%4s')~' ] ','CRIT') ~ $text
    }

our sub header {
    "*****************************************\n" ~
    "***   This is "~coloured('bold','network-check')~" v0.0.1    ***\n" ~
    "***   latest revision: 25.09.2016 by  ***\n" ~
    "*** Yann Büchau (yann.buechau@web.de) ***\n" ~
    "*****************************************"
    }

