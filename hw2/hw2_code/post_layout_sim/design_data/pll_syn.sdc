###################################################################

# Created by write_sdc on Thu Nov 27 16:32:55 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max slow -max_library slow\
                         -min fast -min_library fast
set_max_area 0
set_max_fanout 20 [current_design]
set_load -pin_load 0.005194 [get_ports clk_out]
set_load -pin_load 0.005194 [get_ports locked]
create_clock [get_ports clk]  -name CLK_REF  -period 10  -waveform {0 5}
create_clock [get_pins u_dco/clk_out]  -name CLK_OUT  -period 0.5  -waveform {0 0.25}
set_clock_groups  -asynchronous -name CLK_REF_1  -group [get_clocks CLK_REF]   \
-group [get_clocks CLK_OUT]
set_drive 1  [get_ports clk]
set_drive 1  [get_ports rst_n]
