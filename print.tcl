# terminal::print.tcl
#
#	Terminal printing functions
#
#
# Author: 	G.J.R. Timmer
# Date: 	2017-10-09
#
namespace eval terminal {
    procedure {line} {
        -description
            "Print line on terminal, defaults without newline"
        -example
            "terminal::line ?-msg msg?\n
            terminal::line -clear\n
            terminal::line -nl"
        -args {
            {
                -nl
                -type none
                -optional
                -description "Print NewLine"
            }
            {
                -clear
                -type none
                -optional
                -description "Clear current line"
            }
            {
                -msg
                -type string
                -optional
                -description "Print message"
            }
        }
    } {
        variable options
        
        if { $clear } {
            set r [string repeat " " $options(width)]
            if { $options(resize) } {
                set options(width)  [terminal::screen -width]
                set r [string repeat " " $options(width)]
            }
            puts -nonewline stdout "$r\r"
            flush stdout
        }

        if { [info exists msg] && [string length $msg] > 0 } {
            set msg $msg
        } else {
            set msg {}
        }
        
        if { $nl } {
            append msg "\n"
        } else {
            append msg "\r"
        }
        
        puts -nonewline stdout $msg
        flush stdout
        return -code ok
    }
}
