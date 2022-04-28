//-------------------------------------------------------------------------
//    Ship.sv                                                            --
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


module  spaceShip ( input Reset, frame_clk,
					input [7:0] keycode,
               output [9:0]  ShipX, ShipY, ShipSX, ShipSY );
  
    logic [9:0] Ship_X_Pos, Ship_X_Motion, Ship_Y_Pos, Ship_Y_Motion, Ship_SizeX, Ship_SizeY;
	 
    parameter [9:0] Ship_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ship_Y_Center=440;  // Center position on the Y axis
    parameter [9:0] Ship_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ship_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ship_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ship_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ship_X_Step=3;      // Step size on the X axis
    parameter [9:0] Ship_Y_Step=1;      // Step size on the Y axis

    assign Ship_SizeX = 25;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   assign Ship_SizeY = 25;
	
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ship
        if (Reset)  // Asynchronous Reset
        begin 
            Ship_Y_Motion <= 10'd0; //Ship_Y_Step;
				Ship_X_Motion <= 10'd0; //Ship_X_Step;
				Ship_Y_Pos <= Ship_Y_Center;
				Ship_X_Pos <= Ship_X_Center;
        end
           
        else 
        begin
//				 if ( (Ship_Y_Pos + Ship_Size) >= Ship_Y_Max )  // Ship is at the bottom edge, BOUNCE!
//					  Ship_Y_Motion <= (~ (Ship_Y_Step) + 1'b1);  // 2's complement.
//					  
//				 else if ( (Ship_Y_Pos - Ship_Size) <= Ship_Y_Min )  // Ship is at the top edge, BOUNCE!
//					  Ship_Y_Motion <= Ship_Y_Step;
					  
				 if ( (Ship_X_Pos + Ship_SizeX) >= Ship_X_Max )  // Ship is at the Right edge, BOUNCE!
					  Ship_X_Motion <= (~ (Ship_X_Step) + 1'b1);  // 2's complement.
					  
				 else if ( (Ship_X_Pos) <= Ship_X_Min )  // Ship is at the Left edge, BOUNCE!
					  Ship_X_Motion <= Ship_X_Step;
					  
				 else begin
					  Ship_Y_Motion <= Ship_Y_Motion;  // Ship is somewhere in the middle, don't bounce, just keep moving
					  
				 
				 case (keycode)
					8'h04 : begin
								Ship_X_Motion <= -3;//A
								Ship_Y_Motion<= 0;
							  end
					        
					8'h07 : begin
								
					        Ship_X_Motion <= 3;//D
							  Ship_Y_Motion <= 0;
							  end

							  
//					8'h16 : begin
//					        Ship_Y_Motion <= 1;//S
//							  Ship_X_Motion <= 0;
//							 end
//							  
//					8'h1A : begin
//					        Ship_Y_Motion <= -1;//W
//							  Ship_X_Motion <= 0;
//							 end	
					default: begin
					Ship_X_Motion <= 0;
					Ship_Y_Motion<= 0;
					end
					
			   endcase
				end
				 
				 Ship_Y_Pos <= (Ship_Y_Pos + Ship_Y_Motion);  // Update Ship position
				 Ship_X_Pos <= (Ship_X_Pos + Ship_X_Motion);
			
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ship_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ship_Y_pos.  Will the new value of Ship_Y_Motion be used,
          or the old?  How will this impact behavior of the Ship during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end  
    end
       
    assign ShipX = Ship_X_Pos;
   
    assign ShipY = Ship_Y_Pos;
   
    assign ShipSX = Ship_SizeX;
	 assign ShipSY = Ship_SizeY;
    

endmodule
