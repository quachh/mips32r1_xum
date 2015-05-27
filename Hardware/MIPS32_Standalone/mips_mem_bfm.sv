
`define MEM_FILENAME "add_test.mem"
`define OUT_FILENAME "out.mem"

module mips_mem_bfm
  (
   // Global input
    input clock,
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
    reg        int_DataMem_Ready;
    reg        int_InstMem_Ready;

    reg [31:0] mips_memory [bit [29:0]];

    function automatic logic [31:0] mem_read_32 (ref logic [31:0] mips_memory [bit [29:0]], input bit [29:0] addr);
      mem_read_32 = 32'hxxxx_xxxx;
      if( mips_memory.exists(addr))
        mem_read_32 = mips_memory[addr];
      else
        $display ("no mem found %h ---- %h", addr, mips_memory[addr]);
        
    endfunction: mem_read_32

    function automatic void mem_write_32 (ref logic [31:0] mips_memory [bit [29:0]], input bit [29:0] addr, input logic [31:0] data);
      mips_memory[addr] = data;
    endfunction: mem_write_32


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
   always_ff @(posedge clock) begin
      int_DataMem_Ready <= 1'b0;
      if (DataMem_Read) begin
        int_DataMem_In <= mem_read_32(mips_memory, DataMem_Address);
        if (mips_memory.exists(DataMem_Address))
          int_DataMem_Ready <= 1'b1;
      end
   end

   //////////////////////////////////////////////////////////////////////////////////////////////
   // Data Write requests
   //
   //////////////////////////////////////////////////////////////////////////////////////////////
  always @(posedge clock) begin
    if (!DataMem_Read && ((|DataMem_Write) === 1'b1)) begin
      byte byte0, byte1, byte2, byte3;
      {byte3,byte2,byte1,byte0} = mem_read_32(mips_memory, DataMem_Address);


      if (DataMem_Write [0])
        byte0 = DataMem_Out[7:0];
      if (DataMem_Write [1])
        byte1 = DataMem_Out[15:8];
      if (DataMem_Write [2])
        byte2 = DataMem_Out[23:16];
      if (DataMem_Write [3])
        byte3 = DataMem_Out[31:24];
      mem_write_32 (mips_memory, DataMem_Address, {byte3,byte2,byte1,byte0});
    end
  end

   //////////////////////////////////////////////////////////////////////////////////////////////
   // Instruction read requests
   //
   //////////////////////////////////////////////////////////////////////////////////////////////
  always_ff @(posedge clock) begin
      int_InstMem_Ready <= 1'b0;
      if (InstMem_Read) begin
        int_InstMem_In    <= mem_read_32 (mips_memory, InstMem_Address);
        if (mips_memory.exists(InstMem_Address))
          int_InstMem_Ready <= 1'b1;
      end 

  end

  assign DataMem_In   = int_DataMem_In;
  assign InstMem_In   = int_InstMem_In;
  assign DataMem_Ready = int_DataMem_Ready;
  assign InstMem_Ready = int_InstMem_Ready;

   //write memory out to a file before quitting
  int outfile;
  final begin
      if (file == 1)
        $fclose(`MEM_FILENAME);
        
      outfile = $fopen(`OUT_FILENAME, "w");
      if (outfile == 0)
        $display("\nError: Could not find file %s\n",`OUT_FILENAME);
      else begin
        $writememh(`OUT_FILENAME,mips_memory);
        $fclose(`OUT_FILENAME);
      end  
  end


endmodule // memory_pdp
