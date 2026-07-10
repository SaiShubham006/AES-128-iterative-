module addRoundKey(
    input  [127:0] in,
    input  [127:0] round_key,
    output [127:0] out
);

assign out = in ^ round_key;

endmodule
