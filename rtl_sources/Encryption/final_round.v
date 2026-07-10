module final_round(
  input [127:0] in,
  input [127:0] key,
  output [127:0] out
    );
    wire [127:0] sub_out;
    subBytes i1(in, sub_out);
    
    wire [127:0] shift_row_out;
    ShiftRows i2(sub_out, shift_row_out);
    
    addRoundKey i3(shift_row_out, key, out );
endmodule
