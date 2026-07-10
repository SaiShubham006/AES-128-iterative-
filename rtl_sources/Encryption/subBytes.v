module subBytes(
  input [127:0] in,
  output [127:0] out
    );
    
    genvar i;
    generate
    for(i = 0; i < 16; i = i + 1) begin : subByte
        Sub_box s_inst(.in (in [127 - i*8 -: 8]),.out(out[127 - i*8 -: 8])
        );

    end
    endgenerate    
endmodule
