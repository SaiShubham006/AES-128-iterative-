module aes_round_decrypt(
  input [127:0] cipher_text,
  input [127:0] key,
  output [127:0] text
    );
    
    wire [127:0] inv_shiftRow_out;
    inv_shiftRow i1(cipher_text, inv_shiftRow_out);
    
    wire [127:0] inv_sub_box_out;
    inv_sub_box i2(inv_shiftRow_out, inv_sub_box_out);
    
    wire [127:0] inv_addRound_key_out;
    addRoundKey i3(inv_sub_box_out, key, inv_addRound_key_out);
    
    inv_mixColumn i4(inv_addRound_key_out, text);
endmodule
