`ifndef FWDKM_V
`define FWDKM_V


`include "trig.v"

`define initJntAngle0 0
`define initJntAngle1 112855247
`define initJntAngle2 7877904265
`define _initJntAngle0 -1104420162
`define _initJntAngle1 -991564915
`define _initJntAngle2 6773484103
`define baseHeightInt 290
`define linkLengthInt1 524
`define linkLengthInt2 1064
`define linkLengthInt3 1687


module fwdkm();
	reg clk, reset, enable;

	// member variables
	reg unsigned [31:0] a1;
	// reg unsigned [31:0] a2;
	reg unsigned [31:0] a3;
	reg unsigned [31:0] a4;
	reg unsigned [31:0] _a1;
	// reg unsigned [31:0] _a2;
	reg unsigned [31:0] _a3;
	reg unsigned [31:0] _a4;
	reg unsigned [63:0] d1;

	trig TRIG();


	always @ (posedge reset) begin: init_km
	// initial begin: init_km
		// $display("inside the 'init_km' block");
		a1 = `initJntAngle0;
		a3 = `initJntAngle1;
		a4 = `initJntAngle2;
		_a1 = `_initJntAngle0;
		_a3 = `_initJntAngle1;
		_a4 = `_initJntAngle2;
	end


	task getEEPoseByJntsInt32;
		//input and output
		input unsigned [31:0] jnt_int_0;
		input unsigned [31:0] jnt_int_1;
		input unsigned [31:0] jnt_int_2;
		output unsigned [63:0] ee_pos_x;
		output unsigned [63:0] ee_pos_y;
		output unsigned [63:0] ee_pos_z;

		// local variables
		reg unsigned [31:0] _jnt_int_0;
		reg unsigned [63:0] d2;
		reg unsigned [63:0] d3;
		reg unsigned [63:0] d4;
		reg unsigned [63:0] d5;
		reg unsigned [63:0] d6;
		reg unsigned [63:0] d7;
		reg unsigned [63:0] d8;

		reg [63:0] temp_out;
		reg signed [63:0] cos_temp_out;

		begin
			// #1 reset = 1'b1;
			reset = 1'b1;
			// #1 $display("a1 = %d", a1);
			#1 a1 = a1 + jnt_int_0;
			a3 = a3 + jnt_int_1;
			a4 = a4 - jnt_int_2 - jnt_int_1;
			_a1 = _a1 + jnt_int_0;
			_a3 = _a3 + jnt_int_1;
			_a4 = _a4 - jnt_int_2 - jnt_int_1;

			// #1 $display("a1 = %d", a1);

			d2 = `baseHeightInt;
			d3 = `linkLengthInt1 * 3581808896;	// cosineInt32(_a2) 

			TRIG.cosineInt32(_a3, temp_out);
			d4 = `linkLengthInt2 * temp_out;

			TRIG.cosineInt32(_a4, temp_out);
			d5 = `linkLengthInt3 * temp_out;

			ee_pos_y = d2 + d3 + d4 + d5;

			TRIG.cosineInt32(a4, temp_out);
			d6 = `linkLengthInt3 * temp_out;

			TRIG.cosineInt32(a3, temp_out);
			d7 = `linkLengthInt2 * temp_out;

			d8 = `linkLengthInt1 * 3745731782;	//cosineInt32(a2)

			d1 = d6 - d7 + d8;

			TRIG.cosineInt32(a1, temp_out);
			ee_pos_z = d1 * temp_out;

			TRIG.cosineInt32(_a1, temp_out);
			ee_pos_x = d1 * temp_out;
			
			// $display("d1 = %d", d1);
			// $display("d2 = %d", d2);
			// $display("d3 = %d", d3);			
			// $display("d4 = %d", d4);
			// $display("d5 = %d", d5);
			// $display("y = %d", ee_pos_y);
			// $display("z = %d", ee_pos_z);
			// $display("x = %d", ee_pos_x);
		end
	endtask

endmodule

`endif