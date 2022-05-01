//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab62 (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);




logic Reset_h, vssig, blank, sync, VGA_Clk;


//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST, Collision;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, shipxsig, shipysig, shipsizesigx, shipsizesigy, 
				missilexsig, missileysig, missilesizesigx, missilesizesigy;
	logic [9:0] alienxsig[15], alienysig[15], aliensizesigx[15],aliensizesigy[15];
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;

//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
	HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);
	assign HEX4[7] = 1'b1;
	
	HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
	assign HEX3[7] = 1'b1;
	
	HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
	assign HEX1[7] = 1'b1;
	
	HexDriver hex_driver0 (hex_num_0, HEX0[6:0]);
	assign HEX0[7] = 1'b1;
	
	//fill in the hundreds digit as well as the negative sign
	assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
	
	
	lab62_soc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode)
		
	 );


//instantiate a vga_controller, ball, and color_mapper here with the ports.
//module  vga_controller ( input        Clk,       // 50 MHz clock
//                                      Reset,     // reset signal
//                         output logic hs,        // Horizontal sync pulse.  Active low
//								              vs,        // Vertical sync pulse.  Active low
//												  pixel_clk, // 25 MHz pixel clock output
//												  blank,     // Blanking interval indicator.  Active low.
//												  sync,      // Composite Sync signal.  Active low.  We don't use it in this lab,
//												             //   but the video DAC on the DE2 board requires an input for it.
//								 output [9:0] DrawX,     // horizontal coordinate
//								              DrawY );   // vertical coordinate

vga_controller vga_controller(.Clk(MAX10_CLK1_50), .Reset(Reset_h), .hs(VGA_HS), .vs(VGA_VS), .pixel_clk(VGA_Clk), .blank(blank), .sync(sync), 
								.DrawX(drawxsig), .DrawY(drawysig));
									
//			module  ball ( input Reset, frame_clk,
//					input [7:0] keycode,
//               output [9:0]  BallX, BallY, BallS );

spaceShip spaceship(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .ShipX(shipxsig), .ShipY(shipysig), .ShipSX(shipsizesigx),.ShipSY(shipsizesigy));

//module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
//                       output logic [7:0]  Red, Green, Blue );


Alien Alien0(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[0]), .AlienY(alienysig[0]), .AlienSX(aliensizesigx[0]),.AlienSY(aliensizesigy[0]), .AlienX_Offset(0), .AlienY_Offset(0));
Alien Alien1(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[1]), .AlienY(alienysig[1]), .AlienSX(aliensizesigx[1]),.AlienSY(aliensizesigy[1]), .AlienX_Offset(40), .AlienY_Offset(0));
Alien Alien2(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[2]), .AlienY(alienysig[2]), .AlienSX(aliensizesigx[2]),.AlienSY(aliensizesigy[2]), .AlienX_Offset(80), .AlienY_Offset(0));
Alien Alien3(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[3]), .AlienY(alienysig[3]), .AlienSX(aliensizesigx[3]),.AlienSY(aliensizesigy[3]), .AlienX_Offset(120), .AlienY_Offset(0));
Alien Alien4(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[4]), .AlienY(alienysig[4]), .AlienSX(aliensizesigx[4]),.AlienSY(aliensizesigy[4]), .AlienX_Offset(160), .AlienY_Offset(0));
Alien Alien5(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[5]), .AlienY(alienysig[5]), .AlienSX(aliensizesigx[5]),.AlienSY(aliensizesigy[5]), .AlienX_Offset(0), .AlienY_Offset(25));
Alien Alien6(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[6]), .AlienY(alienysig[6]), .AlienSX(aliensizesigx[6]),.AlienSY(aliensizesigy[6]), .AlienX_Offset(40), .AlienY_Offset(25));
Alien Alien7(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[7]), .AlienY(alienysig[7]), .AlienSX(aliensizesigx[7]),.AlienSY(aliensizesigy[7]), .AlienX_Offset(80), .AlienY_Offset(25));
Alien Alien8(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[8]), .AlienY(alienysig[8]), .AlienSX(aliensizesigx[8]),.AlienSY(aliensizesigy[8]), .AlienX_Offset(120), .AlienY_Offset(25));
Alien Alien9(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[9]), .AlienY(alienysig[9]), .AlienSX(aliensizesigx[9]),.AlienSY(aliensizesigy[9]), .AlienX_Offset(160), .AlienY_Offset(25));
Alien Alien10(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[10]), .AlienY(alienysig[10]), .AlienSX(aliensizesigx[10]),.AlienSY(aliensizesigy[10]), .AlienX_Offset(0), .AlienY_Offset(50));
Alien Alien11(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[11]), .AlienY(alienysig[11]), .AlienSX(aliensizesigx[11]),.AlienSY(aliensizesigy[11]), .AlienX_Offset(40), .AlienY_Offset(50));
Alien Alien12(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[12]), .AlienY(alienysig[12]), .AlienSX(aliensizesigx[12]),.AlienSY(aliensizesigy[12]), .AlienX_Offset(80), .AlienY_Offset(50));
Alien Alien13(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[13]), .AlienY(alienysig[13]), .AlienSX(aliensizesigx[13]),.AlienSY(aliensizesigy[13]), .AlienX_Offset(120), .AlienY_Offset(50));
Alien Alien14(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .AlienX(alienxsig[14]), .AlienY(alienysig[14]), .AlienSX(aliensizesigx[14]),.AlienSY(aliensizesigy[14]), .AlienX_Offset(160), .AlienY_Offset(50));

					
missile missile(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .Collision(Collision), .ShipX(shipxsig), .ShipY(shipysig), .Ship_sizeX(shipsizesigx), .MissileX(missilexsig), 
		.MissileY(missileysig), .MissileSX(missilesizesigx), .MissileSY(missilesizesigy));

color_mapper color_mapper(.pixel_clk(VGA_Clk), .Reset(Reset_h), .ShipX(shipxsig), .ShipY(shipysig), .AlienX(alienxsig), .AlienY(alienysig), .DrawX(drawxsig), .DrawY(drawysig), 
					.MissileX(missilexsig), .MissileY(missileysig), .Missile_sizeX(missilesizesigx), .Missile_sizeY(missilesizesigy),
					.Ship_sizeX(shipsizesigx), .Ship_sizeY(shipsizesigy), .Alien_sizeX(aliensizesigx), .Alien_sizeY(aliensizesigy), .Collision(Collision), .uiucColor(uiuc_Color),
					.Red(Red), .Green(Green), .Blue(Blue), .blank(blank));
					
///// ROM Instantations /////////
logic [9:0] uiucRom_Address;
logic [3:0] uiucPalette_Address;
logic [23:0] uiuc_Color;

spriteController spriteController(.Clk(MAX10_CLK1_50), .drawX(drawxsig), .drawY(drawysig), .ShipX(shipxsig), .ShipY(shipysig), .Ship_Address(uiucRom_Address));

uiucROM uiucROM(.read_address(uiucRom_Address), .Clk(MAX10_CLK1_50), .data_Out(uiucPalette_Address));
uiucPalette uiucPalette(.read_address(uiucPalette_Address), .Clk(MAX10_CLK1_50), .data_Out(uiuc_Color));


endmodule
