program processorAsserts (clk, reset, OpCode, Funct, DataMem_Read, DataMem_Write, InstMem_Read);
input clk, reset;
input [5:0] OpCode;
input [5:0] Funct;
input DataMem_Read, InstMem_Read;
input [3:0] DataMem_Write;
p1: assert #0 (!(!reset && OpCode inside {6'h1, 6'hb, [6'h14:6'h17], [6'h1c:6'h1f]}))
  else $error ("invalid opcode %6b", OpCode);

property reset1;
	@(posedge clk)
		$rose(reset) |-> ##[0:1] (!$isunknown(DataMem_Read)) & (!$isunknown(DataMem_Write)) & (!$isunknown(InstMem_Read))
endproperty


p2:assert property (@(posedge clk) disable iff (reset)  (OpCode===6'h0 |-> Funct inside {6'h0, 6'h2, 6'h3, 6'h8, 6'h10, 6'h12, [6'h18:6'h1B], [6'h20:6'h27], [6'h2a:6'h2b]}))
	else $error ("invalid OpCode %6h Funct %6h",OpCode, Funct);



p3: assert property  (reset1)
	else $error ("outputs were not known (no X or Z) after reset, DataMem_Read = %1b, DataMem_Write = %4b, InstMem_Read= %1b",DataMem_Read, DataMem_Write , InstMem_Read );


endprogram: processorAsserts
