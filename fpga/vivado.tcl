#!/usr/bin/tclsh

set scriptDir [file normalize [file dirname [info script]]]
set projectRoot [file normalize [file join $scriptDir ..]]

# configuration

set projectName "caravel-arty"
set designPart "xc7a35ticsg324-1L"
set sourcesDir [file join $projectRoot "verilog/rtl"]
set sourceName [file join $sourcesDir "caravel.v"]
set projectDir [file join $projectRoot "build/vivado"]
set reportName [file join $projectDir "${projectName}_utilization.txt"]

# main script

create_project -f $projectName $projectDir -part $designPart
add_files -norecurse "./verilog/rtl/defines.v" \
    "./verilog/rtl/user_defines.v" \
    "./verilog/rtl/pads.v" \
    "./mgmt_core_wrapper/verilog/rtl/mgmt_core.v" \
    "./mgmt_core_wrapper/verilog/rtl/mgmt_core_wrapper.v" \
    "./mgmt_core_wrapper/verilog/rtl/VexRiscv_MinDebug.v" \
    "./verilog/rtl/fpga_ram.v" \
    "./verilog/rtl/clock_div.v" \
    "./verilog/rtl/caravel_clocking.v" \
    "./verilog/rtl/housekeeping.v" \
    "./verilog/rtl/housekeeping_spi.v" \
    "./verilog/rtl/gpio_logic_high.v" \
    "./verilog/rtl/gpio_control_block.v" \
    "./verilog/rtl/gpio_defaults_block.v" \
    "./verilog/rtl/mgmt_protect_hv.v" \
    "./verilog/rtl/mprj_logic_high.v" \
    "./verilog/rtl/mprj2_logic_high.v" \
    "./verilog/rtl/mprj_io.v" \
    "./verilog/rtl/mgmt_protect.v" \
    "./verilog/rtl/user_id_programming.v" \
    "./verilog/rtl/xres_buf.v" \
    "./verilog/rtl/spare_logic_block.v" \
    "./verilog/rtl/constant_block.v" \
    "./verilog/rtl/chip_io.v" \
    "./verilog/rtl/simple_por.v" \
    "./verilog/rtl/gpio_signal_buffering.v" \
    "./verilog/rtl/debug_regs.v" \
    "./verilog/rtl/buff_flash_clkrst.v" \
    "./verilog/rtl/__user_project_wrapper.v" \
    "./verilog/rtl/caravel.v"
import_files -force -norecurse
set_property is_global_include 1 [get_files "defines.v"]
set_property is_global_include 1 [get_files "user_defines.v"]
set_property is_global_include 1 [get_files "pads.v"]
set_property top caravel [current_fileset]
update_compile_order -fileset sources_1
launch_runs synth_1
wait_on_run synth_1
open_run synth_1 -name synth_1
opt_design
report_utilization -file $reportName
