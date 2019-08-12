//Determine the speed of the game
module SignalFrequency(
    // input CLOCK_50, //for test
	input clk,
	input game_level,//has normal level:0 or difficult level:1
    output reg clk10
    );
	 
	reg [22:0] count;
	
	initial
	begin
		count = 0;
		clk10 = 1;
	end
	
	always @ (posedge clk) 
	begin
		if(game_level == 0)
	        begin
				count <= count + 1;
				if (count == 250_0000) 
					begin
						count <= 0;
						clk10 <= ~clk10;
					end
			end
		else if (game_level == 1)
			begin
				count <= count + 1;
				if (count == 125_0000) 
					begin
						count <= 0;
						clk10 <= ~clk10;
					end
			end
	end

endmodule