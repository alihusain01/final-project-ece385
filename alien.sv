//-------------------------------------------------------------------------
//    Alien.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  Alien ( input Reset, frame_clk,
					input [7:0] keycode,
					input logic [9:0] AlienX_Offset, AlienY_Offset,
               output [9:0]  AlienX, AlienY, AlienSX, AlienSY
					);
    
    logic [9:0] Alien_X_Pos, Alien_X_Motion, Alien_Y_Pos, Alien_Y_Motion, Alien_SizeX, Alien_SizeY;
	 
    logic [9:0] Alien_X_Center;  // Center position on the X axis
    logic [9:0] Alien_Y_Center;  // Center position on the Y axis
    logic [9:0] Alien_X_Min;       // Leftmost point on the X axis
    logic [9:0] Alien_X_Max;     // Rightmost point on the X axis
    parameter [9:0] Alien_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Alien_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Alien_X_Step=1;      // Step size on the X axis
    parameter [9:0] Alien_Y_Step=1;      // Step size on the Y axis
	 
	
	 always_comb begin
	 Alien_X_Center = 50 + AlienX_Offset;
	 Alien_Y_Center = 50 + AlienY_Offset;
	 Alien_X_Min= AlienX_Offset; 
	 Alien_X_Max= 639 - 160 + AlienX_Offset;
	 end

    assign Alien_SizeX = 25;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign Alien_SizeY= 20;
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Alien
        if (Reset)  // Asynchronous Reset
        begin 
            Alien_Y_Motion <= 10'd0; //Alien_Y_Step;
				Alien_X_Motion <= 1'b1; //Alien_X_Step;
				Alien_Y_Pos <= Alien_Y_Center;
				Alien_X_Pos <= Alien_X_Center;
        end
           
        else 
        begin 
				 if ( (Alien_Y_Pos + Alien_SizeY) >= Alien_Y_Max )  // Alien is at the bottom edge, BOUNCE!
					  begin
					  Alien_Y_Motion <= (~ (Alien_Y_Step) + 1'b1);  // 2's complement.
					//  Alien_Destroyed=1'b1;
					  end
				 else if ( (Alien_Y_Pos - Alien_SizeY) <= Alien_Y_Min )  // Alien is at the top edge, BOUNCE!
					  Alien_Y_Motion <= Alien_Y_Step;
					  
				 else if ( (Alien_X_Pos + Alien_SizeX) >= Alien_X_Max )  // Alien is at the Right edge, BOUNCE!
					  begin
					  Alien_Y_Pos += 25;
					  Alien_X_Pos -= 1;
					  Alien_X_Motion <= (~ (Alien_X_Step) + 1'b1);  // 2's complement.
					  end			  
				 else if ( (Alien_X_Pos - Alien_SizeX) <= Alien_X_Min )  // Alien is at the Left edge, BOUNCE!
					  begin
					  Alien_Y_Pos += 25;
					  Alien_X_Pos += 1;
					  Alien_X_Motion <= Alien_X_Step;
					  end
				 else begin
					  Alien_Y_Motion <= Alien_Y_Motion;  // Alien is somewhere in the middle, don't bounce, just keep moving
					  Alien_X_Motion <= Alien_X_Motion;
					  end
					  
				 
//				 case (keycode)
//					8'h04 : begin
//								Alien_X_Motion <= -1;//A
//								Alien_Y_Motion<= 0;
//							  end
//					        
//					8'h07 : begin
//								
//					        Alien_X_Motion <= 1;//D
//							  Alien_Y_Motion <= 0;
//							  end
//
//							  
//					8'h16 : begin
//					        Alien_Y_Motion <= 1;//S
//							  Alien_X_Motion <= 0;
//							 end
//							  
//					8'h1A : begin
//					        Alien_Y_Motion <= -1;//W
//							  Alien_X_Motion <= 0;
//							 end	  
//					default: ;
//			   endcase
				 
				 Alien_Y_Pos = (Alien_Y_Pos + Alien_Y_Motion);  // Update Alien position
				 Alien_X_Pos = (Alien_X_Pos + Alien_X_Motion);
			
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Alien_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Alien_Y_pos.  Will the new value of Alien_Y_Motion be used,
          or the old?  How will this impact behavior of the Alien during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end  
    end
       
    assign AlienX = Alien_X_Pos;
    assign AlienY = Alien_Y_Pos;
	 
   
    assign AlienSX = Alien_SizeX;
    assign AlienSY = Alien_SizeY;
	 //assign AlienDestroyed=Alien_Destroyed;
endmodule
