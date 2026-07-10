module keyExpansion(
  input [127:0] orig_key,
  input [3:0] round,
  output [127:0] round_key
    );
    
    reg [31:0] Rcon [1:10];
    initial begin
    Rcon[1]=32'h01000000;
    Rcon[2]=32'h02000000;
    Rcon[3]=32'h04000000;
    Rcon[4]=32'h08000000;
    Rcon[5]=32'h10000000;
    Rcon[6]=32'h20000000;
    Rcon[7]=32'h40000000;
    Rcon[8]=32'h80000000;
    Rcon[9]=32'h1b000000;
    Rcon[10]=32'h36000000;
    end
    
    wire [31:0] g_function_out;
    wire [31:0] words [3:0];
    
    assign words[0] = orig_key[127:96];
    assign words[1] = orig_key[95:64];
    assign words[2] = orig_key[63:32];
    assign words[3] = orig_key[31:0];
    
    g_function i1(words[3],Rcon[round],g_function_out);
    
    assign round_key[127:96]= words[0]^g_function_out;
    assign round_key[95:64]= words[1]^round_key[127:96];
    assign round_key[63:32]= words[2]^round_key[95:64];
    assign round_key[31:0]= words[3]^round_key[63:32];
endmodule
