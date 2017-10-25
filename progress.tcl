# terminal::progress.tcl
#
#	Terminal progresss bar
#
#
# Author: 	G.J.R. Timmer
# Date: 	2017-10-09
#
namespace eval terminal {
    procedure {progress} {
        -description
            "Print Progressbar"
        -args {
            {
                -prefix
                -type string
                -optional
                -description "Print prefix before bar"
            }
            {
                -total
                -type integer
                -mandatory
                -description "Total amount"
            }
            {
                -current
                -type integer
                -mandatory
                -description "Current Progress"
            }
            {
                -percent
                -type none
                -optional
                -description "Print % Completed"
            }
        }
    } {
        variable options
        
        # Clear current line
        terminal::line -clear
        
        set bar {}
        set width $options(width)
        if { [info exists prefix] && [string length $prefix] > 0 } {
            set bar $prefix
            if { [string index $bar end] ne " " } {
                append bar " "
            }
            
            set width [expr {$width - [string length $bar]}]
        }
        
        # Update Bar Width current status
        set barfmt  "|%s%s%s"
        set suffix  "|"
        set sargs   [list]
        
        if { $percent } {
            set suffix "${suffix} %3d%% |"
        }
        set width [expr {$width - [string length $suffix]}]
        
        set completed   [expr {int((double($current) / double($total)) * 100)}]
        set barfill     [expr {int(double($width) * double(double($completed) / 100))}]
        set barremain   [expr {$width - $barfill}]
        
        if { $percent } {
            lappend sargs $completed
        }
        terminal::line -clear -msg "${bar}[format ${barfmt} [string repeat "=" $barfill] [string repeat " " $barremain] [format $suffix {*}$sargs]]"
    }
}
