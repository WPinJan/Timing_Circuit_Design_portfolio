set ref_cycle 10 
set DESIGN_TOP pll

#/*--------------------------------------------------------------*/
#/*----------------------- 1.Read files -------------------------*/
#/*--------------------------------------------------------------*/

# 把 pll.v 跟 dco.v 都讀進來
analyze -format verilog {../1.RTL_simulation/pll.v}

# 展開 top
elaborate $DESIGN_TOP

# corner 設定：沿用 fast / slow
set_operating_conditions -min_library fast -min fast \
                         -max_library slow -max slow

#/*--------------------------------------------------------------*/
#/*--------------- 2. Set design constraints --------------------*/ 
#/*--------------------------------------------------------------*/

# PLL 的輸入 clock
create_clock -name CLK_REF -period $ref_cycle [get_ports clk]

create_clock -name CLK_OUT -period 0.5 [get_pins u_dco/clk_out]

create_generated_clock -name CLK_DIV \
    -source [get_pins u_dco/clk_out] \
    -divide_by 10 \
    [get_pins clk_shift[5]]

set_clock_groups -asynchronous \
    -group {CLK_REF} \
    -group {CLK_OUT CLK_DIV}

# 不要讓 DC 去 buffer clock tree
set_dont_touch_network [get_clocks clk]

# 修 hold
set_fix_hold clk

# input drive / output load
set_drive 1 [all_inputs] 
set_load  [load_of slow/CLKBUFX20/A] [all_outputs]

#/*--------------------------------------------------------------*/
#/*------- 2.5 保護 DCO（不要讓 DC 動裡面的 gate） ------------*/
#/*--------------------------------------------------------------*/

# 保護整個 dco design，不要優化 mapping
set_dont_touch [get_design dco]

# 再保護一次 instance
set_dont_touch [get_cells -hierarchical u_dco]

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

report_area                               >  ./pll_syn.report
report_timing -path full -delay max      >> ./pll_syn.report
report_power                             >> ./pll_syn.report

write -format verilog -hierarchy -output ./pll_syn.v
write -format verilog -hierarchy -output ../3.Post_layout_Simulation/APR/design_data/pll_syn.v

write_sdf -version 2.1 -context verilog -load_delay cell ./pll_syn.sdf 
write_sdc ../3.Post_layout_Simulation/APR/design_data/pll_syn.sdc 

exit

