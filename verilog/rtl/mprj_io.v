// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

// `ifdef CARAVEL_FPGA
// `default_nettype wire
// `else
// `default_nettype none
// `endif

/* Define the array of GPIO pads.  Note that the analog project support
 * version of caravel (caravan) defines fewer GPIO and replaces them
 * with analog in the chip_io_alt module.  Because the pad signalling
 * remains the same, `MPRJ_IO_PADS does not change, so a local parameter
 * is made that can be made smaller than `MPRJ_IO_PADS to accommodate
 * the analog pads.
 */

module mprj_io #(
    parameter AREA1PADS = `MPRJ_IO_PADS_1,
    parameter TOTAL_PADS = `MPRJ_IO_PADS
) (
    inout vddio,
    inout vssio,
    inout vdda,
    inout vssa,
    inout vccd,
    inout vssd,

    inout vdda1,
    inout vdda2,
    inout vssa1,
    inout vssa2,

    input vddio_q,
    input vssio_q,
    input analog_a,
    input analog_b,
    input porb_h,
    input [TOTAL_PADS-1:0] vccd_conb,
    inout [TOTAL_PADS-1:0] io,
    input [TOTAL_PADS-1:0] io_out,
    input [TOTAL_PADS-1:0] oeb,
    input [TOTAL_PADS-1:0] enh,
    input [TOTAL_PADS-1:0] inp_dis,
    input [TOTAL_PADS-1:0] ib_mode_sel,
    input [TOTAL_PADS-1:0] vtrip_sel,
    input [TOTAL_PADS-1:0] slow_sel,
    input [TOTAL_PADS-1:0] holdover,
    input [TOTAL_PADS-1:0] analog_en,
    input [TOTAL_PADS-1:0] analog_sel,
    input [TOTAL_PADS-1:0] analog_pol,
    input [TOTAL_PADS*3-1:0] dm,
    output [TOTAL_PADS-1:0] io_in,
    output [TOTAL_PADS-1:0] io_in_3v3,
    inout [TOTAL_PADS-10:0] analog_io,
    inout [TOTAL_PADS-10:0] analog_noesd_io
);

    wire [TOTAL_PADS-1:0] loop0_io;	// Internal loopback to 3.3V domain ground
    wire [TOTAL_PADS-1:0] loop1_io;	// Internal loopback to 3.3V domain power
    wire [6:0] no_connect_1a, no_connect_1b;
    wire [1:0] no_connect_2a, no_connect_2b;

	IOBUF_INTERMDISABLE #(
		.USE_IBUFDISABLE("TRUE")
	) area1_io_pad [AREA1PADS - 1:0] (
		.O(io_in[AREA1PADS - 1:0]),
		.INTERMDISABLE(1'b0),
		.I(io_out[AREA1PADS - 1:0]),
		.IBUFDISABLE(~inp_dis[AREA1PADS - 1:0]),
		.IO(io[AREA1PADS - 1:0]),
		.T(oeb[AREA1PADS - 1:0])
	);

	IOBUF_INTERMDISABLE #(
		.USE_IBUFDISABLE("TRUE")
	) area2_io_pad [TOTAL_PADS - AREA1PADS - 1:0] (
		.O(io_in[TOTAL_PADS - 1:AREA1PADS]),
		.INTERMDISABLE(1'b0),
		.I(io_out[TOTAL_PADS - 1:AREA1PADS]),
		.IBUFDISABLE(~inp_dis[TOTAL_PADS - 1:AREA1PADS]),
		.IO(io[TOTAL_PADS - 1:AREA1PADS]),
		.T(oeb[TOTAL_PADS - 1:AREA1PADS])
	);

endmodule
// `default_nettype wire
