module gpio_logic_high(
 `ifdef USE_POWER_PINS
         inout vccd1,
         inout vssd1,
  `endif

   output wire gpio_logic1
);

assign gpio_logic1 = 1'b1;

endmodule
