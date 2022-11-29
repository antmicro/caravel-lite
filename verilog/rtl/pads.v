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
`ifndef TOP_ROUTING 
	`define USER1_ABUTMENT_PINS \
	.AMUXBUS_A(analog_a),\
	.AMUXBUS_B(analog_b),\
	.VSSA(vssa1),\
	.VDDA(vdda1),\
	.VSWITCH(vddio),\
	.VDDIO_Q(vddio_q),\
	.VCCHIB(vccd),\
	.VDDIO(vddio),\
	.VCCD(vccd),\
	.VSSIO(vssio),\
	.VSSD(vssd),\
	.VSSIO_Q(vssio_q),

	`define USER2_ABUTMENT_PINS \
	.AMUXBUS_A(analog_a),\
	.AMUXBUS_B(analog_b),\
	.VSSA(vssa2),\
	.VDDA(vdda2),\
	.VSWITCH(vddio),\
	.VDDIO_Q(vddio_q),\
	.VCCHIB(vccd),\
	.VDDIO(vddio),\
	.VCCD(vccd),\
	.VSSIO(vssio),\
	.VSSD(vssd),\
	.VSSIO_Q(vssio_q),

	`define MGMT_ABUTMENT_PINS \
	.AMUXBUS_A(analog_a),\
	.AMUXBUS_B(analog_b),\
	.VSSA(vssa),\
	.VDDA(vdda),\
	.VSWITCH(vddio),\
	.VDDIO_Q(vddio_q),\
	.VCCHIB(vccd),\
	.VDDIO(vddio),\
	.VCCD(vccd),\
	.VSSIO(vssio),\
	.VSSD(vssd),\
	.VSSIO_Q(vssio_q),
`else 
	`define USER1_ABUTMENT_PINS 
	`define USER2_ABUTMENT_PINS 
	`define MGMT_ABUTMENT_PINS 
`endif

`define HVCLAMP_PINS(H,L) \
	.DRN_HVC(H), \
	.SRC_BDY_HVC(L)

`define LVCLAMP_PINS(H1,L1,H2,L2,L3) \
	.BDY2_B2B(L3), \
	.DRN_LVC1(H1), \
	.DRN_LVC2(H2), \
	.SRC_BDY_LVC1(L1), \
	.SRC_BDY_LVC2(L2)

`define INPUT_PAD(X,Y,CONB_ONE,CONB_ZERO) \
	IBUF X``_pad ( \
		.O(Y), \
		.I(X) \
	);

`define OUTPUT_PAD(X,Y,CONB_ONE,CONB_ZERO,INPUT_DIS,OUT_EN_N) \
	IOBUF_INTERMDISABLE #( \
		.USE_IBUFDISABLE("TRUE") \
	) X``_pad ( \
		.O(Y), \
		.INTERMDISABLE(1'b0), \
		.I(Y_OUT), \
		.IBUFDISABLE(~INPUT_DIS), \
		.IO(X), \
		.T(OUT_EN_N) \
	);

`define OUTPUT_NO_INP_DIS_PAD(X,Y,CONB_ONE,CONB_ZERO,OUT_EN_N) \
	OBUFT X``_pad ( \
		.O(X), \
		.I(Y), \
		.T(OUT_EN_N) \
	);

`define INOUT_PAD(X,Y,CONB_ONE,CONB_ZERO,Y_OUT,INPUT_DIS,OUT_EN_N,MODE) \
	IOBUF_INTERMDISABLE #( \
		.USE_IBUFDISABLE("TRUE") \
	) X``_pad ( \
		.O(Y), \
		.INTERMDISABLE(1'b0), \
		.I(Y_OUT), \
		.IBUFDISABLE(~INPUT_DIS), \
		.IO(X), \
		.T(OUT_EN_N) \
	);

// `default_nettype wire
