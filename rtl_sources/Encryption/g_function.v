module g_function(
  input [31:0] in_word,
  input  [31:0] rcon,
  output [31:0] out_word
    );
    
    wire [31:0] rot_in_word;
    assign rot_in_word={in_word[23:0],in_word[31:24]};
    
    wire [31:0] sub_in_word;
    Sub_box s1(rot_in_word[31:24],sub_in_word[31:24]);
    Sub_box s2(rot_in_word[23:16],sub_in_word[23:16]);
    Sub_box s3(rot_in_word[15:8],sub_in_word[15:8]);
    Sub_box s4(rot_in_word[7:0],sub_in_word[7:0]);
    
    assign out_word=sub_in_word^rcon;
endmodule
