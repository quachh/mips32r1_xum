module testbench();
    parameter string MEM_FILENAME = "doa_new.mem";
    parameter string OUT_FILENAME = "out.mem";

		wire  clock;
    wire  reset;
    // Data Memory Interface
    wire  [31:0] DataMem_In;
    wire  DataMem_Ready;
    wire DataMem_Read;
    wire [3:0]  DataMem_Write;        // 4-bit Write, one for each byte in word.
    wire [29:0] DataMem_Address;      // Addresses are words, not bytes.
    wire [31:0] DataMem_Out;
    // Instruction Memory Interface
    wire  [31:0] InstMem_In;
    wire [29:0] InstMem_Address;      // Addresses are words, not bytes.
    wire  InstMem_Ready;
    wire InstMem_Read;
	
	bind Processor processorAsserts ac1(.clk(clock), .reset(reset), .OpCode, .Funct, .DataMem_Read, .DataMem_Write, .InstMem_Read);
	bind Processor AssertChecks ac2(clock, reset, OpCode, Funct, Rs, Rt, Rd, Immediate, JumpAddress, Cp0_Sel, InstMem_In);
    Processor p1 (.*, .IP(), .Interrupts(5'b0), .NMI(1'b0));

    mips_mem_bfm #(.MEM_FILENAME(MEM_FILENAME), .OUT_FILENAME(OUT_FILENAME)) mem1 (.*);
    clkgen clk1 (.*);
endmodule
