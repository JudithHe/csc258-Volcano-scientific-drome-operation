module VGAFrequency(
    // input CLOCK_50, //for test
	 input clk,
    output reg VGAclk
    );
	 
	//we write an initial block just for simulation convenience
	initial
	begin
		VGAclk = 1;
	end

	always @ (posedge clk) 
	begin
		VGAclk <= ~VGAclk; // VGAclk is 25 MHz since CLOCK_50 is 50MHZ
	end

endmodule