module Sub_box(
  input [7:0] in,
  output [7:0] out
    );
    reg [7:0] S_box [0:255]; 
    initial $readmemh("S_box.mem", S_box);
    
    assign out=S_box[in];
endmodule
