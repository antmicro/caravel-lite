module buff_flash_clkrst (
	`ifdef USE_POWER_PINS
		inout VPWR,
		inout VGND,
	`endif
	input[10:0] in_n, 
	input[2:0] in_s, 
	output[10:0] out_s, 
	output[2:0] out_n);

`ifdef CARAVEL_FPGA
	assign out_s = in_n;
	assign out_n = in_s;
`else
	sky130_fd_sc_hd__clkbuf_8 BUF[13:0] (
		`ifdef USE_POWER_PINS
			.VGND(VGND),
			.VNB(VGND),
			.VPB(VPWR),
			.VPWR(VPWR),
		`endif
		.A({in_n, in_s}), 
		.X({out_s, out_n})); 
`endif

endmodule