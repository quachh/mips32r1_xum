
`include "mips_pkg.sv"


module AssertChecks(
					input clk,
					input reset,
					input [5:0] OpCode,
					input [5:0] Funct,
					input [4:0] Rs, Rt, Rd,
					input [15:0] Immediate,
					input [25:0] JumpAddress,
					input [2:0] Cp0_Sel,
					input [31:0]InstMem_In);


reg [31:0] Instruction ;
reg [5:0] OpCode_check;
reg [4:0] Rs_check, Rt_check, Rd_check;
reg [15:0] Immediate_check;
reg [25:0] JumpAddress_check;
reg [2:0] Cp0_Sel_check;
reg [5:0]Funct_check;

import mips_pkg::*;

always_ff@(negedge clk)
begin
		OpCode_assertion: assert(OpCode_check == OpCode)
		else $error("Opcode Failed");
		
		if(OpCode_check== (Op_Type_CP0||Op_Type_R|| Op_Type_R2))begin
		
		
			R_type_decode: assert(Rs_check == Rs && 
								 	 Rt_check == Rt &&
								 	 Rd_check == Rd &&
								 	 Funct_check == Funct)
			else $error("R-Type Instruction Decode Failed");
			
		end
		
		else if((OpCode_check == Op_J) || (OpCode_check ==Op_Jal))
		begin
			
			J_type_decode: assert(JumpAddress_check == JumpAddress)
			else $error("J-Type Instruction Decode Failed");
			
		end
		
		else
		begin
			I_type_decode: assert(Rs_check == Rs &&
								  Rt_check == Rt &&
								  Immediate_check == Immediate)
   			else $error("I-Type Instruction Decode Failed");
   		end		
	 
end
//assertion for instruction execute
/*always@(negedge clk)
label2:assert property(outputs) else $error;

property outputs
@(negedge opcode) ##5 outputs 
endproperty: outputs
*/


always_ff @(posedge clk)
begin

		Instruction=InstMem_In;
	
end	


always_comb
begin    
     
	 	case(OpCode_check)
	 	
	 	
	 	(Op_Type_CP0||Op_Type_R|| Op_Type_R2):begin
	 		
	 		Rs_check = Instruction[25:21];
    		Rt_check = Instruction[20:16];
   			Rd_check = Instruction[15:11];
    		Funct_check = Instruction[5:0];
    		Cp0_Sel_check = Instruction[2:0];
   
    	end
    	(Op_J || Op_Jal):begin
    		JumpAddress_check = Instruction[25:0];
    	end
    	
    	default : begin
    		Rs_check = Instruction[25:21];
    		Rt_check = Instruction[20:16];
    		Immediate_check = Instruction[15:0];
    	end		
    	
    	endcase
    	
end
    	
endmodule
    			
    	
	 		
	 	
	