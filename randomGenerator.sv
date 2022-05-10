module randomGenerator(input logic Clk, Reset,
								input [7:0] keycode,
								input logic [9:0] AlienX[15], AlienY[15],
								output logic fireAlienMissile[15]);
								
logic start;
 
 always_comb begin
 if(keycode == 8'h2C) start = 1'b1;
 else start = 1'b0;
 end
								
always_ff @ (posedge Reset or posedge Clk or posedge start) begin
if (Reset || start) begin
fireAlienMissile = '{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
end

else if((AlienY[14] == (10'd100) && (AlienX[14] == (10'd450))))
begin
fireAlienMissile[0] = 1'b0;
fireAlienMissile[1] = 1'b0;
fireAlienMissile[2] = 1'b0;
fireAlienMissile[3] = 1'b0;
fireAlienMissile[4] = 1'b0;
fireAlienMissile[5] = 1'b0;
fireAlienMissile[6] = 1'b0;
fireAlienMissile[7] = 1'b0;
fireAlienMissile[8] = 1'b0;
fireAlienMissile[9] = 1'b0;
fireAlienMissile[10] = 1'b0;
fireAlienMissile[11] = 1'b0;
fireAlienMissile[12] = 1'b0;
fireAlienMissile[13] = 1'b0;
fireAlienMissile[14] = 1'b1;
end
//else if((AlienY[9] == (10'd75) && (AlienX[9] == (10'd250))))
//begin
//fireAlienMissile[0] = 1'b0;
//fireAlienMissile[1] = 1'b0;
//fireAlienMissile[2] = 1'b0;
//fireAlienMissile[3] = 1'b0;
//fireAlienMissile[4] = 1'b0;
//fireAlienMissile[5] = 1'b0;
//fireAlienMissile[6] = 1'b0;
//fireAlienMissile[7] = 1'b0;
//fireAlienMissile[8] = 1'b0;
//fireAlienMissile[9] = 1'b1;
//fireAlienMissile[10] = 1'b0;
//fireAlienMissile[11] = 1'b0;
//fireAlienMissile[12] = 1'b0;
//fireAlienMissile[13] = 1'b0;
//fireAlienMissile[14] = 1'b0;
//end
else if((AlienY[2] == (10'd100) && (AlienX[2] == (10'd400))))
begin
fireAlienMissile[0] = 1'b0;
fireAlienMissile[1] = 1'b1;
fireAlienMissile[2] = 1'b0;
fireAlienMissile[3] = 1'b0;
fireAlienMissile[4] = 1'b0;
fireAlienMissile[5] = 1'b0;
fireAlienMissile[6] = 1'b0;
fireAlienMissile[7] = 1'b0;
fireAlienMissile[8] = 1'b0;
fireAlienMissile[9] = 1'b0;
fireAlienMissile[10] = 1'b0;
fireAlienMissile[11] = 1'b0;
fireAlienMissile[12] = 1'b0;
fireAlienMissile[13] = 1'b0;
fireAlienMissile[14] = 1'b0;
end

//else if((AlienY[1] == (10'd150) && (AlienX[1] == (10'd100))))
//begin
//fireAlienMissile[0] = 1'b0;
//fireAlienMissile[1] = 1'b0;
//fireAlienMissile[2] = 1'b0;
//fireAlienMissile[3] = 1'b1;
//fireAlienMissile[4] = 1'b0;
//fireAlienMissile[5] = 1'b0;
//fireAlienMissile[6] = 1'b0;
//fireAlienMissile[7] = 1'b0;
//fireAlienMissile[8] = 1'b0;
//fireAlienMissile[9] = 1'b0;
//fireAlienMissile[10] = 1'b0;
//fireAlienMissile[11] = 1'b0;
//fireAlienMissile[12] = 1'b0;
//fireAlienMissile[13] = 1'b0;
//fireAlienMissile[14] = 1'b0;
//end
//
//else if((AlienY[1] == (10'd200) && (AlienX[1] == (10'd100))))
//begin
//fireAlienMissile[0] = 1'b0;
//fireAlienMissile[1] = 1'b0;
//fireAlienMissile[2] = 1'b0;
//fireAlienMissile[3] = 1'b1;
//fireAlienMissile[4] = 1'b0;
//fireAlienMissile[5] = 1'b0;
//fireAlienMissile[6] = 1'b0;
//fireAlienMissile[7] = 1'b0;
//fireAlienMissile[8] = 1'b0;
//fireAlienMissile[9] = 1'b0;
//fireAlienMissile[10] = 1'b0;
//fireAlienMissile[11] = 1'b0;
//fireAlienMissile[12] = 1'b0;
//fireAlienMissile[13] = 1'b0;
//fireAlienMissile[14] = 1'b0;
//end

else
begin
fireAlienMissile[0] = 1'b0;
fireAlienMissile[1] = 1'b0;
fireAlienMissile[2] = 1'b0;
fireAlienMissile[3] = 1'b0;
fireAlienMissile[4] = 1'b0;
fireAlienMissile[5] = 1'b0;
fireAlienMissile[6] = 1'b0;
fireAlienMissile[7] = 1'b0;
fireAlienMissile[8] = 1'b0;
fireAlienMissile[9] = 1'b0;
fireAlienMissile[10] = 1'b0;
fireAlienMissile[11] = 1'b0;
fireAlienMissile[12] = 1'b0;
fireAlienMissile[13] = 1'b0;
fireAlienMissile[14] = 1'b0;
end

end

endmodule
