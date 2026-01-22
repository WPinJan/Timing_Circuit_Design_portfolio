set ref_cycle 1
set DESIGN_TOP dcc

#/*--------------------------------------------------------------*/
#/*----------------------- 1.Read files -------------------------*/
#/*--------------------------------------------------------------*/

# 把 dcc.v 跟 tdl.v 都讀進來
analyze -format verilog {../1.RTL_simulation/dcc.v}

# 展開 top
elaborate $DESIGN_TOP

# corner 設定：沿用 fast / slow
set_operating_conditions -min_library fast -min fast \
                         -max_library slow -max slow

#/*--------------------------------------------------------------*/
#/*--------------- 2. Set design constraints --------------------*/ 
#/*--------------------------------------------------------------*/

create_clock -name CLK -period $ref_cycle [get_ports clk]

# 不要讓 DC 動 clock network（針對 port/net）
set_dont_touch_network [get_ports clk]

# 修 hold（針對 clock object）
set_fix_hold [get_clocks CLK]

# input drive / output load
set_drive 1 [all_inputs] 
set_load  [load_of slow/CLKBUFX20/A] [all_outputs]

#/*--------------------------------------------------------------*/
#/*------- 2.5 保護 DCO（不要讓 DC 動裡面的 gate） ------------*/
#/*--------------------------------------------------------------*/

# 保護整個 tdl design，不要優化、不要重 mapping
set_dont_touch [get_designs tdl]

# 如果你的 instance 名稱叫 u_tdl（在 dcc 裡面）
# 再保護一次 instance（雙保險）
set_dont_touch [get_cells -hierarchical tdl_1]
set_dont_touch [get_cells -hierarchical tdl_2]

# 注意：這樣 DC 仍然會讀到 tdl 裡面的 standard cells，
# 可以做 timing，也可以寫 SDF，只是「結構不會被改動」。

#/*--------------------------------------------------------------*/
#/*----------------- 3.Check and Link Design --------------------*/ 
#/*--------------------------------------------------------------*/

link 
check_design
uniquify
set_fix_multiple_port_nets -all -buffer_constants  

#/*--------------------------------------------------------------*/
#/*------------------------ 4.Compile ---------------------------*/ 
#/*--------------------------------------------------------------*/

# Setting DRC Constraint
set_max_fanout 20.0 $DESIGN_TOP

# Area Constraint
set_max_area   0

# before synthesis settings
set case_analysis_with_logic_constants true
set_fix_multiple_port_nets -all -buffer_constants

set_clock_gating_style -max_fanout 10

compile -map_effort medium 

# remove dummy ports
remove_unconnected_ports [get_cells -hierarchical *]
remove_unconnected_ports [get_cells -hierarchical *] -blast_buses

check_design 

# rename / bus style
set bus_inference_style {%s[%d]}
set bus_naming_style {%s[%d]}
set hdlout_internal_busses true
#change_names -hierarchy -rule verilog
#define_name_rules name_rule -allowed {a-z A-Z 0-9 _} -max_length 255 -type cell
#define_name_rules name_rule -allowed {a-z A-Z 0-9 _[]} -max_length 255 -type net
#define_name_rules name_rule -map {{"\*cell\*" "cell"}}
#define_name_rules name_rule -map {{"*-return", "myreturn"}}
#define_name_rules name_rule -case_insensitive
#change_names -hierarchy -rules name_rule

set verilogout_show_unconnected_pins true  

#/*--------------------------------------------------------------*/ 
#/*----------------------- 5.Write out files --------------------*/ 
#/*--------------------------------------------------------------*/

report_area                               >  ./dcc_syn.report
report_timing -path full -delay max      >> ./dcc_syn.report
report_power                             >> ./dcc_syn.report

write -format verilog -hierarchy -output ./dcc_syn.v
write -format verilog -hierarchy -output ../3.Post_layout_Simulation/APR/design_data/dcc_syn.v

write_sdf -version 2.1 -context verilog -load_delay cell ./dcc_syn.sdf 
write_sdc ../3.Post_layout_Simulation/APR/design_data/dcc_syn.sdc 

exit

