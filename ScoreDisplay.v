module ScoreDisplay(
	 // input CLOCK_50, //for test	
	input clk,
    input [7:0] score,
	output [6:0] HEX2, HEX1, HEX0 
    );
	
	reg [3:0] dig_2;
	reg [3:0] dig_1;
	reg [3:0] dig_0;
	
	always @ (posedge clk)
	begin
		dig_2 <= score / 8'd100; // score/100
		dig_1 <= (score / 8'd10) % 8'd10;  // (score/10)%10
		dig_0 <= score % 8'd10; // score%10
	end

	dec_decoder D0(
		.dec_digit(dig_0),
		.segments(HEX0)
		);

	dec_decoder D1(
		.dec_digit(dig_1),
		.segments(HEX1)
		);

	dec_decoder D2(
		.dec_digit(dig_2),
		.segments(HEX2)
		);

endmodule

module dec_decoder(dec_digit, segments);
    input [3:0] dec_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (dec_digit)
            4'd0: segments = 7'b100_0000;
            4'd1: segments = 7'b111_1001;
            4'd2: segments = 7'b010_0100;
            4'd3: segments = 7'b011_0000;
            4'd4: segments = 7'b001_1001;
            4'd5: segments = 7'b001_0010;
            4'd6: segments = 7'b000_0010;
            4'd7: segments = 7'b111_1000;
            4'd8: segments = 7'b000_0000;
            4'd9: segments = 7'b001_1000;
			default: segments = 7'b0;
        endcase
endmodule