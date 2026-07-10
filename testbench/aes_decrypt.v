module tb_aes_iterative;

reg clk;
reg reset;
reg start;
reg [127:0] cipher_text;
reg [127:0] key;

wire [127:0] plain_text;
wire busy;
wire valid;

aes_iterative_decrypt dut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .cipher_text(cipher_text),
    .key(key),
    .plain_text(plain_text),
    .busy(busy),
    .valid(valid)
);

//--------------------------------------------------
// Clock Generation
//--------------------------------------------------
always #5 clk = ~clk;

//--------------------------------------------------
// Test
//--------------------------------------------------
initial begin

    clk = 0;
    reset = 0;
    start = 0;

    key= 128'h00000000000000000000000000000000;
    cipher_text = 128'h66e94bd4ef8a2c3b884cfa59ca342b2e;

    #20;
    reset = 1;

    #10;
    start = 1;

    #10;
    start = 0;

    wait(valid);

    #1;

    $display("----------------------------------------");
    $display("Expected Plaintext : 00000000000000000000000000000000");
    $display("Received Plaintext : %032h", plain_text);

    if (plain_text == 128'h00000000000000000000000000000000)
        $display("******** PASS ********");
    else
        $display("******** FAIL ********");

    $display("----------------------------------------");

    #20;
    $finish;

end

always @(posedge clk) begin
    $display("--------------------------------");
    $display("Time= %0t", $time);
    $display("State= %0d",dut.curr_state);
    $display("NextState= %0d",dut.next_state);
    $display("Round= %0d",dut.round_number);
    $display("Busy= %b",busy);
    $display("Valid= %b", valid);
    $display("Key       = %032h", dut.intm_key_out);
    $display("StateReg  = %032h", dut.state_reg);
    $display("RoundOut  = %032h", dut.cipher_text_out_round);
    $display("FinalOut  = %032h", dut.cipher_text_out_final);
    $display("PlainText = %032h", plain_text);
end

endmodule
