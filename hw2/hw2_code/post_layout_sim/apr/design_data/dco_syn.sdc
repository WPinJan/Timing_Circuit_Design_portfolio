###################################################################

# Created by write_sdc on Fri Nov 14 12:41:02 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max slow -max_library slow\
                         -min fast -min_library fast
set_max_area 0
set_max_fanout 20 [current_design]
set_load -pin_load 0.005194 [get_ports clk_out]
set_drive 1  [get_ports {lambda[9]}]
set_drive 1  [get_ports {lambda[8]}]
set_drive 1  [get_ports {lambda[7]}]
set_drive 1  [get_ports {lambda[6]}]
set_drive 1  [get_ports {lambda[5]}]
set_drive 1  [get_ports {lambda[4]}]
set_drive 1  [get_ports {lambda[3]}]
set_drive 1  [get_ports {lambda[2]}]
set_drive 1  [get_ports {lambda[1]}]
set_drive 1  [get_ports {lambda[0]}]
set_drive 1  [get_ports e]
