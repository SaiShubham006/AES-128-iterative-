module inv_mixColumn(
  input [127:0] in,
  output [127:0] out
    );
    
    function[7:0] times2(input[7:0] byte);
    begin
      if(byte[7]) times2=(byte<<1)^8'h1b;
      else times2=byte<<1;
    end
    endfunction
    
    function [7:0] times9(input[7:0] byte); 
      reg [7:0] x2,x4,x8;
      begin
        x2=times2(byte);
        x4=times2(x2);
        x8=times2(x4);
        times9=x8^byte;
      end
    endfunction
    
    function [7:0] timesb(input[7:0] byte); 
      reg [7:0] x2,x4,x8;
      begin
        x2=times2(byte);
        x4=times2(x2);
        x8=times2(x4);
        timesb=x8^x2^byte;
      end
    endfunction
    
    function [7:0] timesd(input[7:0] byte); 
      reg [7:0] x2,x4,x8;
      begin
        x2=times2(byte);
        x4=times2(x2);
        x8=times2(x4);
        timesd=x8^x4^byte;
      end
    endfunction
    
    function [7:0] timese(input[7:0] byte); 
      reg [7:0] x2,x4,x8;
      begin
        x2=times2(byte);
        x4=times2(x2);
        x8=times2(x4);
        timese=x8^x2^x4;
      end
    endfunction
    
    //column1
    assign out[127:120]=timese(in[127:120])^timesb(in[119:112])^timesd(in[111:104])^times9(in[103:96]);
    assign out[119:112]=times9(in[127:120])^timese(in[119:112])^timesb(in[111:104])^timesd(in[103:96]);
    assign out[111:104]=timesd(in[127:120])^times9(in[119:112])^timese(in[111:104])^timesb(in[103:96]);
    assign out[103:96]=timesb(in[127:120])^timesd(in[119:112])^times9(in[111:104])^timese(in[103:96]);
    //column2
    assign out[95:88]=timese(in[95:88])^timesb(in[87:80])^timesd(in[79:72])^times9(in[71:64]);
    assign out[87:80]=times9(in[95:88])^timese(in[87:80])^timesb(in[79:72])^timesd(in[71:64]);
    assign out[79:72]=timesd(in[95:88])^times9(in[87:80])^timese(in[79:72])^timesb(in[71:64]);
    assign out[71:64]=timesb(in[95:88])^timesd(in[87:80])^times9(in[79:72])^timese(in[71:64]);
    //column3
    assign out[63:56]=timese(in[63:56])^timesb(in[55:48])^timesd(in[47:40])^times9(in[39:32]);
    assign out[55:48]=times9(in[63:56])^timese(in[55:48])^timesb(in[47:40])^timesd(in[39:32]);
    assign out[47:40]=timesd(in[63:56])^times9(in[55:48])^timese(in[47:40])^timesb(in[39:32]);
    assign out[39:32]=timesb(in[63:56])^timesd(in[55:48])^times9(in[47:40])^timese(in[39:32]);
    //column4
    assign out[31:24]=timese(in[31:24])^timesb(in[23:16])^timesd(in[15:8])^times9(in[7:0]);
    assign out[23:16]=times9(in[31:24])^timese(in[23:16])^timesb(in[15:8])^timesd(in[7:0]);
    assign out[15:8]=timesd(in[31:24])^times9(in[23:16])^timese(in[15:8])^timesb(in[7:0]);
    assign out[7:0]=timesb(in[31:24])^timesd(in[23:16])^times9(in[15:8])^timese(in[7:0]);
endmodule
