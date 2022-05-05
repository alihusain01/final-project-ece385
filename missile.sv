//-------------------------------------------------------------------------
//    Ball.sv                                                            --
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


module  missile ( input Reset, frame_clk, Collision,
					input [7:0] keycode,
					input [9:0] ShipX, ShipY, Ship_sizeX,
               output logic [9:0]  MissileX, MissileY, MissileSX, MissileSY);
    
    logic [9:0] Missile_X_Pos, Missile_X_Motion, Missile_Y_Pos, Missile_Y_Motion, Missile_SizeX, Missile_SizeY;
	 
    logic [9:0] Missile_X_On_Ship;  // Center position on the X axis
    logic [9:0] Missile_Y_On_Ship;  // Center position on the Y axis
    logic [9:0] Missile_X_Min;       // Leftmost point on the X axis
    logic [9:0] Missile_X_Max;     // Rightmost point on the X axis
    parameter [9:0] Missile_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Missile_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Missile_X_Step=3;      // Step size on the X axis
    parameter [9:0] Missile_Y_Step=4;      // Step size on the Y axis

    assign Missile_SizeX = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign Missile_SizeY = 6;
	 
	 always_comb begin
	 Missile_X_On_Ship = ShipX + (Ship_sizeX /2);
	 Missile_Y_On_Ship = ShipY;
	 Missile_X_Min = Ship_sizeX/2;
	 Missile_X_Max = 639 - (Ship_sizeX/2);
	 end
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Missile
        if (Reset)  // Asynchronous Reset
        begin 
            Missile_Y_Motion <= 10'd0; //Missile_Y_Step;
				Missile_X_Motion <= 10'd0; //Missile_X_Step;
				Missile_Y_Pos = Missile_Y_On_Ship;
				Missile_X_Pos = Missile_X_On_Ship;
        end
		  
        else 
        begin 
//				 if ( (Missile_Y_Pos + Missile_Size) >= Missile_Y_Max )  // Missile is at the bottom edge, BOUNCE!
//					  Missile_Y_Motion <= (~ (Missile_Y_Step) + 1'b1);  // 2's complement.
					  
				  if ( ((Missile_Y_Pos) <= Missile_Y_Min) || Collision == 1'b1)  // Missile is at the top edge, 
					   begin
							Missile_Y_Motion <= 10'd0; //Missile_Y_Step;
							Missile_X_Motion <= 10'd0; //Missile_X_Step;
							Missile_Y_Pos = Missile_Y_On_Ship+4;
							Missile_X_Pos = Missile_X_On_Ship;
						end 
					
				  else if ( (Missile_X_Pos + Missile_SizeX) >= Missile_X_Max )  // Missile is at the Right edge, BOUNCE!
					  Missile_X_Motion <= (~ (Missile_X_Step) + 1'b1);  // 2's complement.
					  
				 else if ( (Missile_X_Pos ) <= Missile_X_Min )  // Missile is at the Left edge, BOUNCE!
					  Missile_X_Motion <= Missile_X_Step;
					 
					  
				 else begin
					  Missile_Y_Motion <= Missile_Y_Motion;  // Missile is somewhere in the middle, don't bounce, just keep moving
				 
				 case (keycode)
					8'h04 : begin
									if(Missile_Y_Pos >= ShipY) begin
										Missile_X_Motion <= -3;//A
										Missile_Y_Motion<= 0;
									end
					        end
					8'h07 : begin
									if(Missile_Y_Pos >= ShipY) begin
										Missile_X_Motion <= 3;//D
										Missile_Y_Motion <= 0;
									end
							  end
//
//							  
//					8'h16 : begin
//					        Missile_Y_Motion <= 1;//S
//							  Missile_X_Motion <= 0;
//							 end
							  
					8'h1A : begin
					        Missile_Y_Motion <= -4;//W
							  Missile_X_Motion <= 0;
							 end	  
					default: begin
						Missile_X_Motion <= 0;
						 
					end
			   endcase
				end
				 
				 Missile_Y_Pos = (Missile_Y_Pos + Missile_Y_Motion);  // Update Missile position
				 Missile_X_Pos = (Missile_X_Pos + Missile_X_Motion);
			
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end  
    end
       
    assign MissileX = Missile_X_Pos;
   
    assign MissileY = Missile_Y_Pos;
   
    assign MissileSX = Missile_SizeX;
	 assign MissileSY = Missile_SizeY;
    

endmodule
