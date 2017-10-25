# terminal::terminal.tcl
#
#	Terminal configuration
#
#
# Author: 	G.J.R. Timmer
# Date: 	2017-10-09
#
namespace eval terminal {
    variable options
    
    # Set Defaults
    set options(resize)     0
    set options(width)      [terminal::screen -width]
    
    procedure {configure} {
        -description
            "Configure Terminal"
        -example
            "terminal::configure ?options?"
        -args {
            {
                -resize
                -type string
                -optional
                -choices {0 1}
                -choicelabels {off on}
                -description "Set autoresize on/off"
            }
        }
    } {
        variable options
        
        if { [info exists resize] && [string length $resize] > 0 } {
            set options(resize) $resize
        }
    }
}
