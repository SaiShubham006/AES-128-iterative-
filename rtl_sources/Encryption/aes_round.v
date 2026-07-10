module aes_round(
  input [127:0] in,
  input [127:0] key,
  output [127:0] out
    );
    wire [127:0] sub_out;
    subBytes i1(in, sub_out);
    
    wire [127:0] shift_row_out;
    ShiftRows i2(sub_out, shift_row_out);
    
    wire [127:0] mix_col_out;
    mixColumn i3(shift_row_out, mix_col_out );
    
    //wire [127:0] roundkey_out;
    addRoundKey i4(mix_col_out, key, out );
endmodule
