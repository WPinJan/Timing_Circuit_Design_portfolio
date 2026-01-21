###################################################################

# Created by write_sdc on Sat Nov  1 17:36:49 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max slow -max_library slow\
                         -min fast -min_library fast
set_max_area 0
set_max_fanout 20 [current_design]
set_load -pin_load 0.005194 [get_ports {y[9]}]
set_load -pin_load 0.005194 [get_ports {y[8]}]
set_load -pin_load 0.005194 [get_ports {y[7]}]
set_load -pin_load 0.005194 [get_ports {y[6]}]
set_load -pin_load 0.005194 [get_ports {y[5]}]
set_load -pin_load 0.005194 [get_ports {y[4]}]
set_load -pin_load 0.005194 [get_ports {y[3]}]
set_load -pin_load 0.005194 [get_ports {y[2]}]
set_load -pin_load 0.005194 [get_ports {y[1]}]
set_load -pin_load 0.005194 [get_ports {y[0]}]
set_load -pin_load 0.005194 [get_ports {x[3]}]
set_load -pin_load 0.005194 [get_ports {x[2]}]
set_load -pin_load 0.005194 [get_ports {x[1]}]
set_load -pin_load 0.005194 [get_ports {x[0]}]
set_load -pin_load 0.005194 [get_ports done]
create_clock [get_ports clk]  -period 2.5  -waveform {0 0.65}
set_drive 1  [get_ports clk]
set_drive 1  [get_ports rst_n]
set_drive 1  [get_ports {y_t[9]}]
set_drive 1  [get_ports {y_t[8]}]
set_drive 1  [get_ports {y_t[7]}]
set_drive 1  [get_ports {y_t[6]}]
set_drive 1  [get_ports {y_t[5]}]
set_drive 1  [get_ports {y_t[4]}]
set_drive 1  [get_ports {y_t[3]}]
set_drive 1  [get_ports {y_t[2]}]
set_drive 1  [get_ports {y_t[1]}]
set_drive 1  [get_ports {y_t[0]}]
set_drive 1  [get_ports start]
