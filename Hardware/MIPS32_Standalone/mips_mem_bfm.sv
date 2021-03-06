


module mips_mem_bfm (clock, DataMem_In, DataMem_Ready, DataMem_Read, DataMem_Write, DataMem_Address, DataMem_Out, InstMem_In, InstMem_Ready, InstMem_Address, InstMem_Read);

    parameter string MEM_FILENAME = "test.mem";
    parameter string OUT_FILENAME = "out.mem";
    parameter string GOLDEN_FILENAME = {MEM_FILENAME,"_golden"};

	 // Global input
    input clock;
    // NOTE: port names are with respected to CPU i.e. : DataMem_In is data going INto CPU
    // Data Memory Interface
    output  [31:0]    DataMem_In;
    output            DataMem_Ready;
    input             DataMem_Read;
    input   [3:0]     DataMem_Write;        // 4-bit Write, one for each byte in word.
    input   [29:0]    DataMem_Address;      // Addresses are words, not bytes.
    input   [31:0]    DataMem_Out;
    // Instruction Memory Interface
    output  [31:0]    InstMem_In;
    output            InstMem_Ready;
    input   [29:0]    InstMem_Address;      // Addresses are words, not bytes.
    input             InstMem_Read;

    reg [31:0] int_DataMem_In;
    reg [31:0] int_InstMem_In;
    reg        int_DataMem_Ready;
    reg        int_DataRead_Ready;
    reg        int_DataWrite_Ready;
    reg        int_InstMem_Ready;

    reg [31:0] mips_memory [bit [29:0]];
    reg [31:0] mips_golden [bit [29:0]];

    function automatic logic [31:0] mem_read_32 (ref logic [31:0] mips_memory [bit [29:0]], input bit [29:0] addr);
      mem_read_32 = 32'hxxxx_xxxx;
      if( mips_memory.exists(addr))
        mem_read_32 = mips_memory[addr];

    endfunction: mem_read_32

    function automatic void mem_write_32 (ref logic [31:0] mips_memory [bit [29:0]], input bit [29:0] addr, input logic [31:0] data);
      mips_memory[addr] = data;
    endfunction: mem_write_32


    int file;
    // Fill the memory with values taken from a data file
    initial begin
      file = $fopen(MEM_FILENAME, "r");
      if (file == 0)
         $display("\nError: Could not find file %s\n",MEM_FILENAME);
      else begin
        $display("Running test file %s\n",MEM_FILENAME);
        $readmemh(MEM_FILENAME,mips_memory);
      end
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
      int_DataRead_Ready <= 1'b0;
      if (DataMem_Read) begin
        int_DataMem_In <= mem_read_32(mips_memory, DataMem_Address);
        if (mips_memory.exists(DataMem_Address))
          int_DataRead_Ready <= 1'b1;
      end
   end

   //////////////////////////////////////////////////////////////////////////////////////////////
   // Data Write requests
   //
   //////////////////////////////////////////////////////////////////////////////////////////////
  always @(posedge clock) begin
    int_DataWrite_Ready <= 1'b0;
    if (!DataMem_Read && ((|DataMem_Write) === 1'b1)) begin
      byte byte0, byte1, byte2, byte3;
      {byte3,byte2,byte1,byte0} <= mem_read_32(mips_memory, DataMem_Address);


      if (DataMem_Write [0])
        byte0 <= DataMem_Out[7:0];
      if (DataMem_Write [1])
        byte1 <= DataMem_Out[15:8];
      if (DataMem_Write [2])
        byte2 <= DataMem_Out[23:16];
      if (DataMem_Write [3])
        byte3 <= DataMem_Out[31:24];
      mem_write_32 (mips_memory, DataMem_Address, {byte3,byte2,byte1,byte0});
      int_DataWrite_Ready <= 1'b1;
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
  assign DataMem_Ready = int_DataRead_Ready || int_DataWrite_Ready;
  assign InstMem_Ready = int_InstMem_Ready;

   //write memory out to a file before quitting
  int outfile;
  int golden_sim;
  final begin
      if (mips_memory[30'h800] === 32'hACED)
        $display ("MEM TEST PASSED");
      else if (mips_memory[30'h800] === 32'hDEAD)
        $display ("MEM TEST FAILED");
      else
         $display ("UNABLE TO DETERMINE ACED/DEAD TEST VIA MEMORY");

      if (file == 0)
        $fclose(MEM_FILENAME);

      golden_sim = $fopen(GOLDEN_FILENAME, "r");
      if (file == 0)
        $display("\nError: Could not find file %s\n",GOLDEN_FILENAME);
      else begin
        $readmemh(GOLDEN_FILENAME,mips_golden);
        foreach (mips_golden[i]) begin
          if (mips_golden[i] ==! mips_memory[i])
            $error ("Memory Address %32h mismatches Result: %32h  Golden: %32h", i, mips_memory[i], mips_golden[i]);
        end
      end

      outfile = $fopen(OUT_FILENAME, "w");
      if (outfile == 0)
        $display("\nError: Could not find file %s\n",OUT_FILENAME);
      else begin
        $writememh(OUT_FILENAME,mips_memory);
        $fclose(OUT_FILENAME);
      end
  end



endmodule // memory_pdp
