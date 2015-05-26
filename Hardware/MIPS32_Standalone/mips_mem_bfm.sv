// =======================================================================
//   Department of Electrical and Computer Engineering
//   Portland State University
//
//   Course name:  ECE 510 - Pre-Silicon Validation
//   Term & Year:  Spring 2015
//   Instructor :  Tareque Ahmad
//
//   Project:      Hardware implementation of PDP8 
//                 Instruction Set Architecture (ISA) level simulator
//
//   Filename:     memory_pdp.sv
//   Description:  TBD
//   Created by:   Tareque Ahmad
//   Date:         May 08, 2015
//
//   Copyright:    Tareque Ahmad 
// =======================================================================

`define MEM_FILENAME "test.mem"
`define OUT_FILENAME "out.mem"

module mips_mem_bfm
  (
   // Global input
    input clk,
    // NOTE: port names are with repected to CPU ie : DataMem_In is data going IN to CPU
    // Data Memory Interface
    output  [31:0]    DataMem_In,
    output            DataMem_Ready,
    input             DataMem_Read, 
    input   [3:0]     DataMem_Write,        // 4-bit Write, one for each byte in word.
    input   [29:0]    DataMem_Address,      // Addresses are words, not bytes.
    input   [31:0]    DataMem_Out,
    // Instruction Memory Interface
    output  [31:0]    InstMem_In,
    output            InstMem_Ready,
    input   [29:0]    InstMem_Address,      // Addresses are words, not bytes.
    input             InstMem_Read

   );

    reg [31:0] int_DataMem_In;
    reg [31:0] int_InstMem_In;
    
    reg [7:0] mips_memory [bit [31:0]];
    
    function logic [31:0] mem_read_32 (bit [31:0] addr);
     read = 32'hxx;
     if( mips_memory.exist(addr))
      mem_read = {mips_memory[addr+3],mips_memory[addr+2],mips_memory[addr+1],mips_memory[addr]};
    endfunction: mem_read
    
    function void mem_write_8 (bit [31:0] addr, logic [7:0] data);
      mips_memory[addr] = data;
    endfunction: mem_write
    
    
    int file;
    // Fill the memory with values taken from a data file
    initial begin
      file = $fopen(`MEM_FILENAME, "r");
      if (file == 0)
         $display("\nError: Could not find file %s\n",`MEM_FILENAME);
      else
         $readmemh(`MEM_FILENAME,mips_memory);
    end

    // Display the contents of memory
    
    //initial begin
    //    $display("Contents of Mem after reading data file:");
    //    for (mips_memory[l])  begin
    //        $display("%d:%h",l,mips_memory[l]);
    //    end
    //end


   //////////////////////////////////////////////////////////////////////////////////////////////
   // Data read requests
   //
   //////////////////////////////////////////////////////////////////////////////////////////////
   always_ff @(posedge clk) begin
      if (DataMem_Read) begin
        int_DataMem_In <= mem_read({ifu_rd_addr, 2'b00});
        DataMem_Ready = 1'b1;
      end else begin
        DataMem_Ready = 1'b0; 
      end
   end

   //////////////////////////////////////////////////////////////////////////////////////////////
   // Data Write requests
   //
   //////////////////////////////////////////////////////////////////////////////////////////////
  always @(posedge clk) begin
    if ((|DataMem_Write) === 1'b1) begin
      if (DataMem_Write [0])
        mem_write_8 ({DataMem_Address, 2'b00}, DataMem_Out[7:0])
      if (DataMem_Write [1])
        mem_write_8 ({DataMem_Address, 2'b01}, DataMem_Out[15:8])
      if (DataMem_Write [2])
        mem_write_8 ({DataMem_Address, 2'b10}, DataMem_Out[23:16])
      if (DataMem_Write [3])
        mem_write_8 ({DataMem_Address, 2'b11}, DataMem_Out[31:24])
    end
  end

   //////////////////////////////////////////////////////////////////////////////////////////////
   // Instruction read requests
   //
   //////////////////////////////////////////////////////////////////////////////////////////////
  always_ff @(posedge clk) begin
      if (InstMem_Read) begin
        int_InstMem_In    = mem_read_32 ({InstMem_Address, 2'b00});
        InstMem_Ready = 1'b1; 
      end else begin
        InstMem_Ready = 1'b0; 
      end

  end

  assign DataMem_In   = int_DataMem_In;
  assign InstMem_In   = int_InstMem_In;

   //write memory out to a file before quitting
  int outfile;
  final begin
      outfile = $fopen(`OUT_FILENAME, "w");
      if (outfile == 0)
        $display("\nError: Could not find file %s\n",`OUT_FILENAME);
      else
        $writememh(`OUT_FILENAME,mips_memory);
  end



endmodule // memory_pdp
