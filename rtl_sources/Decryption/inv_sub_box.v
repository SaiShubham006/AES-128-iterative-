module inv_sub_box(
  input [127:0] in,
  output [127:0] out
    );
    
    genvar i;
    generate
      for(i=0; i<16; i=i+1) begin: s_box_sub
        inv_subBytes inst(in[127-8*i-:8], out[127-8*i-:8]);
      end
    endgenerate
endmodule
