module mixColumn(
  input[127:0] in,
  output [127:0] out
    );
    
    function [7:0] double(input [7:0] in);
    begin
      if(in[7]) double=(in<<1)^8'h1b;
      else double=in<<1;
    end
    endfunction
    
    function [7:0] triple(input [7:0] in);
    begin
      triple=double(in)^in;
    end
    endfunction
    
    //column 1
    assign out[127:120]=double(in[127:120])^triple(in[119:112])^in[111:104]^in[103:96];
    assign out[119:112]=in[127:120]^double(in[119:112])^triple(in[111:104])^in[103:96];
    assign out[111:104]=in[127:120]^in[119:112]^double(in[111:104])^triple(in[103:96]);
    assign out[103:96]=triple(in[127:120])^in[119:112]^in[111:104]^double(in[103:96]);
    //column 2
    assign out[95:88]=double(in[95:88])^triple(in[87:80])^in[79:72]^in[71:64];
    assign out[87:80]=in[95:88]^double(in[87:80])^triple(in[79:72])^in[71:64];
    assign out[79:72]=in[95:88]^in[87:80]^double(in[79:72])^triple(in[71:64]);
    assign out[71:64]=triple(in[95:88])^in[87:80]^in[79:72]^double(in[71:64]);
    //column 3
    assign out[63:56]=double(in[63:56])^triple(in[55:48])^in[47:40]^in[39:32];
    assign out[55:48]=in[63:56]^double(in[55:48])^triple(in[47:40])^in[39:32];
    assign out[47:40]=in[63:56]^in[55:48]^double(in[47:40])^triple(in[39:32]);
    assign out[39:32]=triple(in[63:56])^in[55:48]^in[47:40]^double(in[39:32]);
    //column 4
    assign out[31:24]=double(in[31:24])^triple(in[23:16])^in[15:8]^in[7:0];
    assign out[23:16]=in[31:24]^double(in[23:16])^triple(in[15:8])^in[7:0];
    assign out[15:8]=in[31:24]^in[23:16]^double(in[15:8])^triple(in[7:0]);
    assign out[7:0]=triple(in[31:24])^in[23:16]^in[15:8]^double(in[7:0]);
endmodule
