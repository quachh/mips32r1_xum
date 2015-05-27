

// Declare time paramemters
timeunit 1ns;
timeprecision 1ns;

// Define module
module clkgen
  (
   output clock,
   output reset
   );

   // Define parameters
   parameter CLOCK_PERIOD = 10;
   parameter RESET_DURATION = 500;
   parameter RUN_TIME = 5000000;

   // Define internal registers
   reg int_clk;
   reg int_reset;

   // Generate fixed frequency internal clock
   initial begin
      int_clk = 0;
      forever #(CLOCK_PERIOD/2) int_clk = ~int_clk;
   end

   // Generate one-time internal reset signal
   initial begin
      int_reset = 1;
      # RESET_DURATION int_reset = 0;
      # RUN_TIME
      $finish;
   end

   // Continuous assignment to output
   assign clock = int_clk;
   assign reset = int_reset;

endmodule

