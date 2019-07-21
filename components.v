//mux 2to1
module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;
endmodule


//DFF
module DFF(q, d, clock, reset_n);
	input clock;
	input d;
	input reset_n;
	output q;
	reg q;

	always @(posedge clock)
		begin 
			if (reset_n==1'b0) q<=0;
			else q<=d;
		end
endmodule

//TFF
module MyTFF(t,clk, reset, q);
	input t, clk, reset;
	output q;
	reg q1;
	always @ ( posedge clk, negedge reset)
	  if (~reset) begin
		q1 <= 1'b0;
	  end else if (t) begin
		q1 <=  ! q;
	 end
	 assign q = q1;
endmodule
// Shift register
module ShiftRegister(q, d, clock, reset_n, enable);
	input enable;
	input clock;
	input [11:0]d;
	input reset_n; // active low
	output q;
	reg [11:0]q1;
	reg bit_out;
	always @(posedge clock, negedge reset_n)
		begin 
			if (reset_n==1'b0) q1 <= 12'b000_000_000_000;
			else if (enable ==1'b0)	q1 <= d[11:0];
			else
				begin
					q1 <= q1 << 1'b1;
				end
		end
	assign q = (q1[11] == 1'b1) ? 1'b1 : 1'b0;
endmodule

//RATE dividers to slower the clock
module rateDivider(old_clock, new_clock, clear);
	//0.5s
	input old_clock, clear;
	output new_clock;
	reg out_clock;
	reg [26:0]counter;
	always @(posedge old_clock, negedge old_clock, negedge clear)
	begin
		if (~clear) begin // active low
			out_clock <=0;
			counter <=0;
			end
		else 
			begin
				if(counter ==0) 
					begin
						counter <= 25'd24_999_999;
       						out_clock <= ~out_clock;
    					end else begin
        					counter <= counter - 25'd1;
    					end
			end
	end// alwyas end
	assign new_clock = out_clock;
endmodule

// HEX display on 
module Hex(S,H);
        input [3:0]S;
        output [6:0]H;

        assign H[0]=(~S[3]&~S[2]&~S[1]&S[0])|(~S[3]&S[2]&~S[1]&~S[0])|(S[3]&S[2]&~S[1]&S[0])|(S[3]&~S[2]&S[1]&S[0]);

        assign H[1]=(~S[3]&S[2]&~S[1]&S[0])|(S[2]&S[1]&~S[0])|(S[3]&S[1]&S[0])|(S[3]&S[2]&~S[0]);

        assign H[2]=(~S[3]&~S[2]&S[1]&~S[0])|(S[3]&S[2]&~S[0])|(S[3]&S[2]&S[1]);

        assign H[3]=(~S[3]&S[2]&~S[1]&~S[0])|(~S[2]&~S[1]&S[0])|(S[2]&S[1]&S[0])|(S[3]&~S[2]&S[1]&~S[0]);

        assign H[4]=(~S[3]&S[2]&~S[1])|(~S[2]&~S[1]&S[0])|(~S[3]&S[0]);

        assign H[5]=(~S[3]&~S[2]&S[0])|(~S[3]&~S[2]&S[1])|(~S[3]&S[1]&S[0])|(S[3]&S[2]&~S[1]&S[0]);

        assign H[6]=(~S[3]&~S[2]&~S[1])|(~S[3]&S[2]&S[1]&S[0])|(S[3]&S[2]&~S[1]&~S[0]);
endmodule    