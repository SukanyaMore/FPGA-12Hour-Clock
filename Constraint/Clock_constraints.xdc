#System Clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# LEDs
set_property PACKAGE_PIN U16 [get_ports {AM_PM_indicator_led}]
set_property IOSTANDARD LVCMOS33 [get_ports {AM_PM_indicator_led}]
set_property PACKAGE_PIN E19 [get_ports {clock_mode_indicator_led}]
set_property IOSTANDARD LVCMOS33 [get_ports {clock_mode_indicator_led}]

#7 segment display
set_property PACKAGE_PIN W7 [get_ports {segment[0]}]
     set_property IOSTANDARD LVCMOS33 [get_ports {segment[0]}]
set_property PACKAGE_PIN W6 [get_ports {segment[1]}]
     set_property IOSTANDARD LVCMOS33 [get_ports {segment[1]}]
set_property PACKAGE_PIN U8 [get_ports {segment[2]}]
     set_property IOSTANDARD LVCMOS33 [get_ports {segment[2]}]
set_property PACKAGE_PIN V8 [get_ports {segment[3]}]
     set_property IOSTANDARD LVCMOS33 [get_ports {segment[3]}]
set_property PACKAGE_PIN U5 [get_ports {segment[4]}]
     set_property IOSTANDARD LVCMOS33 [get_ports {segment[4]}]
set_property PACKAGE_PIN V5 [get_ports {segment[5]}]
     set_property IOSTANDARD LVCMOS33 [get_ports {segment[5]}]
set_property PACKAGE_PIN U7 [get_ports {segment[6]}]
     set_property IOSTANDARD LVCMOS33 [get_ports {segment[6]}]
     
set_property PACKAGE_PIN U2 [get_ports {enable[0]}]
     set_property IOSTANDARD LVCMOS33 [get_ports {enable[0]}]
set_property PACKAGE_PIN U4 [get_ports {enable[1]}]
     set_property IOSTANDARD LVCMOS33 [get_ports {enable[1]}]
 set_property PACKAGE_PIN V4 [get_ports {enable[2]}]
     set_property IOSTANDARD LVCMOS33 [get_ports {enable[2]}]
 set_property PACKAGE_PIN W4 [get_ports {enable[3]}]
      set_property IOSTANDARD LVCMOS33 [get_ports {enable[3]}]
      
##Buttons
set_property PACKAGE_PIN U18 [get_ports center]						
	set_property IOSTANDARD LVCMOS33 [get_ports center]
set_property PACKAGE_PIN T18 [get_ports up]						
	set_property IOSTANDARD LVCMOS33 [get_ports up]
set_property PACKAGE_PIN W19 [get_ports left]						
	set_property IOSTANDARD LVCMOS33 [get_ports left]
set_property PACKAGE_PIN T17 [get_ports right]						
	set_property IOSTANDARD LVCMOS33 [get_ports right]
set_property PACKAGE_PIN U17 [get_ports down]						
	set_property IOSTANDARD LVCMOS33 [get_ports down]
 