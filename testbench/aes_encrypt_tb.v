`timescale 1ns/1ps

module aes_iterative_tb;

  reg clk;
  reg reset;
  reg start;
  reg [127:0] plain_text;
  reg [127:0] key;

  wire [127:0] cipher_text;
  wire valid;
  wire busy;

  // DUT
  aes_iterative dut(
    .clk(clk),
    .reset(reset),
    .plain_text(plain_text),
    .key(key),
    .start(start),
    .cipher_text(cipher_text),
    .valid(valid),
    .busy(busy)
  );

  // Clock generation
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  
  initial begin

    // Initial values
    reset      = 1'b0;
    start      = 1'b0;
    plain_text = 128'h00112233445566778899aabbccddeeff;
    key        = 128'h000102030405060708090a0b0c0d0e0f;

    // Apply reset
    #20;
    reset = 1'b1;

    // Wait a little
    #10;

    // Start pulse (1 clock cycle)
    @(posedge clk);
    start <= 1'b1;

    @(posedge clk);
    start <= 1'b0;

    // Wait for valid
    wait(valid == 1'b1);

    // Small delay for stable display
    #1;

    // Display outputs
    $display("----------------------------------------");
    $display("PLAINTEXT  : %h", plain_text);
    $display("KEY        : %h", key);
    $display("CIPHERTEXT : %h", cipher_text);
    $display("----------------------------------------");

    // Expected AES-128 ciphertext
    if(cipher_text == 128'h69c4e0d86a7b0430d8cdb78070b4c55a)
      $display("TEST PASSED");
    else
      $display("TEST FAILED");

    #20;
    $finish;

  end

 
  initial begin
    $monitor(
      "TIME=%0t | STATE=%0d | ROUND=%0d | BUSY=%b | VALID=%b",
      $time,
      dut.curr_state,
      dut.round_number,
      busy,
      valid
    );

  end
endmodule
