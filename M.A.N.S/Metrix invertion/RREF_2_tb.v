`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:00:05 10/03/2017
// Design Name:   RREF_2
// Module Name:   D:/Study/SEM_3/CO/verilog/RREF_1/RREF_2_tb.v
// Project Name:  RREF_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RREF_2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RREF_2_tb;

	// Inputs
	reg [31:0] a11;
	reg [31:0] a12;
	reg [31:0] a13;
	reg [31:0] a14;
	reg [31:0] a15;
	reg [31:0] a21;
	reg [31:0] a22;
	reg [31:0] a23;
	reg [31:0] a24;
	reg [31:0] a25;
	reg [31:0] a31;
	reg [31:0] a32;
	reg [31:0] a33;
	reg [31:0] a34;
	reg [31:0] a35;
	reg [31:0] a41;
	reg [31:0] a42;
	reg [31:0] a43;
	reg [31:0] a44;
	reg [31:0] a45;
	reg [31:0] a51;
	reg [31:0] a52;
	reg [31:0] a53;
	reg [31:0] a54;
	reg [31:0] a55;

	// Outputs
	wire [31:0] i11;
	wire [31:0] i12;
	wire [31:0] i13;
	wire [31:0] i14;
	wire [31:0] i15;
	wire [31:0] i21;
	wire [31:0] i22;
	wire [31:0] i23;
	wire [31:0] i24;
	wire [31:0] i25;
	wire [31:0] i31;
	wire [31:0] i32;
	wire [31:0] i33;
	wire [31:0] i34;
	wire [31:0] i35;
	wire [31:0] i41;
	wire [31:0] i42;
	wire [31:0] i43;
	wire [31:0] i44;
	wire [31:0] i45;
	wire [31:0] i51;
	wire [31:0] i52;
	wire [31:0] i53;
	wire [31:0] i54;
	wire [31:0] i55;
	wire [31:0] pivot1;
	wire [31:0] pivot2;
	wire [31:0] pivot3;
	wire [31:0] pivot4;
	wire [31:0] pivot5;

	// Instantiate the Unit Under Test (UUT)
	RREF_2 uut (
		.a11(a11), 
		.a12(a12), 
		.a13(a13), 
		.a14(a14), 
		.a15(a15), 
		.a21(a21), 
		.a22(a22), 
		.a23(a23), 
		.a24(a24), 
		.a25(a25), 
		.a31(a31), 
		.a32(a32), 
		.a33(a33), 
		.a34(a34), 
		.a35(a35), 
		.a41(a41), 
		.a42(a42), 
		.a43(a43), 
		.a44(a44), 
		.a45(a45), 
		.a51(a51), 
		.a52(a52), 
		.a53(a53), 
		.a54(a54), 
		.a55(a55), 
		.i11(i11), 
		.i12(i12), 
		.i13(i13), 
		.i14(i14), 
		.i15(i15), 
		.i21(i21), 
		.i22(i22), 
		.i23(i23), 
		.i24(i24), 
		.i25(i25), 
		.i31(i31), 
		.i32(i32), 
		.i33(i33), 
		.i34(i34), 
		.i35(i35), 
		.i41(i41), 
		.i42(i42), 
		.i43(i43), 
		.i44(i44), 
		.i45(i45), 
		.i51(i51), 
		.i52(i52), 
		.i53(i53), 
		.i54(i54), 
		.i55(i55), 
		.pivot1(pivot1), 
		.pivot2(pivot2), 
		.pivot3(pivot3), 
		.pivot4(pivot4), 
		.pivot5(pivot5)
	);

	initial begin
// Initialize Inputs
		a11 = 5;
		a12 = 3;
		a13 = 1;
		a14 = 7;
		a15 = 9;
		a21 = 6;
		a22 = 4;
		a23 = 2;
		a24 = 8;
		a25 = -8;
		a31 = 7;
		a32 = 5;
		a33 = 3;
		a34 = 10;
		a35 = 9;
		a41 = 9;
		a42 = 6;
		a43 = 4;
		a44 = -9;
		a45 = -5;
		a51 = 8;
		a52 = 5;
		a53 = 2;
		a54 = 11;
		a55 = 4;


		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

