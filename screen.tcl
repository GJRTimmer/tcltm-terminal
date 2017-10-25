# terminal::screen.tcl
#
#	Terminal screen helper function(s)
#
#
# Author: 	G.J.R. Timmer
# Date: 	2017-10-09
#
namespace eval terminal {
    procedure {screen} {
        -description
            "Get RootInfo"
        -example
            "eno::env rootinfo [options]\n
            eno::env rootinfo -version"
        -args {
            {
                -width
                -type none
                -optional
                -description "Get screen width"
            }
        }
    } {
        if { $width } {
             if { [windows_platform] } {
                set res [eno::shell windows "mode"]
                switch -exact -- [dict get $res CODE] {
                    0 {
                        regexp -- {Columns:[*\s]{1,}([0-9]{1,})} $res match columns
                        return $columns
                    }
                    1 {
                        return 80
                    }
                }
            }
    
            set res [eno::shell linux "tput cols"]
            switch -exact -- [dict get $res CODE] {
                0 {
                    return [dict get $res RESULT]
                }
                1 {
                    return 80
                }
            }
        }
    }
}
