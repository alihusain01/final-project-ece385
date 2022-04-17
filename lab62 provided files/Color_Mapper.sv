//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] ShipX, ShipY, DrawX, DrawY, Ball_sizeX, Ball_sizeY, 
							 input [9:0] AlienX[15], AlienY[15],
                       output logic [7:0]  Red, Green, Blue );
    
    logic ship_on,alien_on;
	 int alienCount;
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    int DistX, DistY, SizeX,SizeY;
	 assign DistX = DrawX - ShipX;
    assign DistY = DrawY - ShipY;
    assign SizeX = Ball_sizeX;
	 assign SizeY = Ball_sizeY;
	 
	 int DistXA[15], DistYA[15];
	 int SizeXA, SizeYA;
	 
	 always_comb
	 begin
		 for(int i = 0; i < 15; i++)
		 begin
			 DistXA[i] = DrawX - AlienX[i];
			 DistYA[i] = DrawY - AlienY[i];
		 end
		end
	 
	 assign SizeXA = Ball_sizeX;
	 assign SizeYA = Ball_sizeY;

	 
	 
       
	  
    always_comb
    begin:Ship_on_proc
        //if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) //ball
		  if(DistX>=0 && DistX<=SizeX &&DistY>=0&&DistY<=SizeY)  //square
            ship_on = 1'b1; 
        else 
            ship_on = 1'b0;
     end 
	  
//	always_comb
//	begin	:Alien_on_proc_0
//	 //if ( ( DistX1*DistX1 + DistY1*DistY1) <= (Size1 * Size1) ) //ball
//	 for(int i = 0; i < 15; i++)
//	 begin
//	 if(!(DistXA[i] >= 0 && DistXA[i] <= SizeXA && DistYA[i] >= 0 && DistYA[i] <= SizeYA)) //square
//				begin
//				alien_on = 1'b0;
//				end
//				else 
//            alien_on = 1'b1;
//				break;
//	 end
//	 end

always_comb begin

if((DistXA[0] >= 0 && DistXA[0] <= SizeXA && DistYA[0] >= 0 && DistYA[0] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[1] >= 0 && DistXA[1] <= SizeXA && DistYA[1] >= 0 && DistYA[1] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[2] >= 0 && DistXA[2] <= SizeXA && DistYA[2] >= 0 && DistYA[2] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[3] >= 0 && DistXA[3] <= SizeXA && DistYA[3] >= 0 && DistYA[3] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[4] >= 0 && DistXA[4] <= SizeXA && DistYA[4] >= 0 && DistYA[4] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[5] >= 0 && DistXA[5] <= SizeXA && DistYA[5] >= 0 && DistYA[5] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[6] >= 0 && DistXA[6] <= SizeXA && DistYA[6] >= 0 && DistYA[6] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[7] >= 0 && DistXA[7] <= SizeXA && DistYA[7] >= 0 && DistYA[7] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[8] >= 0 && DistXA[8] <= SizeXA && DistYA[8] >= 0 && DistYA[8] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[9] >= 0 && DistXA[9] <= SizeXA && DistYA[9] >= 0 && DistYA[9] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[10] >= 0 && DistXA[10] <= SizeXA && DistYA[10] >= 0 && DistYA[10] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[11] >= 0 && DistXA[11] <= SizeXA && DistYA[11] >= 0 && DistYA[11] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[12] >= 0 && DistXA[12] <= SizeXA && DistYA[12] >= 0 && DistYA[12] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[13] >= 0 && DistXA[13] <= SizeXA && DistYA[13] >= 0 && DistYA[13] <= SizeYA))
alien_on = 1'b1;
else if((DistXA[14] >= 0 && DistXA[14] <= SizeXA && DistYA[14] >= 0 && DistYA[14] <= SizeYA))
alien_on = 1'b1;
else
alien_on = 1'b0;

end
	
	always_comb
    begin:RGB_Display
        if ((ship_on == 1'b1)) 
        begin 
            Red = 8'hff;
            Green = 8'h55;
            Blue = 8'h00;
        end  
		  else if ((alien_on == 1'b1)) 
        begin 
            Red = 8'h00;
            Green = 8'h55;
            Blue = 8'h00;
        end 
        else 
        begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h7f - DrawX[9:3];
        end      
    end 
    
endmodule
