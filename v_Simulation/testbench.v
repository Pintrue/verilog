`include "trig.v"

module trig_tb;
	reg [63:0] temp_out;
	real a;


	trig T0();

	initial begin
		$display("At 0: m = %d and b = %d", T0.gradTable32[0], T0.interceptTable32[0]);
		$display("At 350: m = %d and b = %d", T0.gradTable32[350], T0.interceptTable32[350]);
		$display("At 351: m = %d and b = %d", T0.gradTable32[351], T0.interceptTable32[351]);
		$display("At 818: m = %d and b = %d", T0.gradTable32[818], T0.interceptTable32[818]);
		$display("At 819: m = %d and b = %d", T0.gradTable32[819], T0.interceptTable32[819]);
		$display("At 1871: m = %d and b = %d", T0.gradTable32[1871], T0.interceptTable32[1871]);
		$display("At 1872: m = %d and b = %d", T0.gradTable32[1872], T0.interceptTable32[1872]);
		$display("At 2456: m = %d and b = %d", T0.gradTable32[2456], T0.interceptTable32[2456]);
		$display("At 2457: m = %d and b = %d", T0.gradTable32[2457], T0.interceptTable32[2457]);
		$display("At 3041: m = %d and b = %d", T0.gradTable32[3041], T0.interceptTable32[3041]);
		$display("At 3042: m = %d and b = %d", T0.gradTable32[3042], T0.interceptTable32[3042]);
		$display("At 4095: m = %d and b = %d", T0.gradTable32[4095], T0.interceptTable32[4095]);

		// $display("Select mask is %b", `RADIANS_LUT_SELECT_MASK_32);

		// T0.cosineInt32(3523215360, temp_out);
		T0.cosineInt32(4294967292, temp_out);
		$display("Value %d is %f after conversion", temp_out, T0.toVal32(temp_out));
	end

	// initial begin
	// end

endmodule