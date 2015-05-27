program processorAsserts (clk, reset, OpCode, DataMem_Read, DataMem_Write, InstMem_Read);
input clk, reset;
input [5:0] OpCode;
input DataMem_Read, InstMem_Read;
input [3:0] DataMem_Write;
p1: assert #0 (!(!reset && OpCode inside {6'h1, 6'hb, [6'h14:6'h17], [6'h1c:6'h1f]}))
  else $error ("invalid opcode %6b", OpCode);

property reset1;
	@(posedge clk)
		reset |-> ##[0:1] (DataMem_Read ===0'b0) & (DataMem_Write === 4'b0) & (InstMem_Read);
endproperty

p2: assert property  (reset1)
	else $error ("output is not 0 after reset");

endprogram: processorAsserts
