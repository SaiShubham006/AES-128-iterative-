module inv_subBytes(
  input [7:0] in,
  output [7:0] out
    );
    
    reg [7:0] inv_s_box[0:255];
    initial $readmemh("inv_s_box.mem", inv_s_box);
    
    assign out=inv_s_box[in];
endmodule
