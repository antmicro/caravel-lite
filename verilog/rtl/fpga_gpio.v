`default_nettype wire

module fpga_gpio (
    inout pad_io,
    input chip_o,
    output chip_i,
    input chip_oe,
    input chip_ie
);

    assign chip_i = (chip_ie ? pad_io : 'bz);
    assign pad_io = (chip_oe ? chip_o : 'bz);

endmodule