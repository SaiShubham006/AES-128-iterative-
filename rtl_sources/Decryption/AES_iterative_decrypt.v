module aes_iterative_decrypt(
  input clk, 
  input reset,
  input start,
  input [127:0] cipher_text,
  input [127:0] key,
  output reg [127:0] plain_text,
  output busy,
  output valid
    );
    
    //wire keys_valid;
    reg[2:0] curr_state, next_state;
    reg[3:0] round_number;
    //reg[127:0] key_storage[0:10];
    wire[127:0] intm_key_out;
    //reg[127:0] intm_key_in;
    reg[127:0] key_reg, cipher_reg;
    
    reg[127:0] state_reg;
    wire[127:0] cipher_text_out_round;
    wire[127:0] cipher_text_out_final;
    wire[127:0] cipher_text_out_10;
    
    aes_round_decrypt i1(state_reg, intm_key_out, cipher_text_out_round);
    inv_keyExpansion i2(key_reg, round_number, intm_key_out);
    final_round_decrypt i3(state_reg, intm_key_out, cipher_text_out_final);
    addRoundKey i4(cipher_reg, intm_key_out, cipher_text_out_10);
    
    localparam idle=3'b000, init=3'b001, round=3'b010, final=3'b011, finish=3'b100;
    
    always@(*)begin
    
    case(curr_state)

      idle: begin
        if(start) next_state=init;
        else next_state=idle;
      end
      
      init:begin
        next_state=round;
      end
      
      round:begin
        if (round_number==4'd1) next_state=final;
        else next_state=round;
      end
      
      final: begin
        next_state=finish;
      end
      
      finish: begin
        next_state=idle;
      end
      
      default: begin
        next_state=idle;
      end  
    endcase
    end
    
    always@(posedge clk or negedge reset)begin
      if(!reset) begin
        curr_state<=idle;
        plain_text<=128'b0;
        round_number<=4'b0;
        state_reg<=128'b0;
        key_reg<= 128'b0;
        cipher_reg <=128'b0;
      end
      
      else begin
        curr_state<=next_state;
        case(curr_state)
          
          idle:begin
            if(start) begin 
              round_number<=4'd10;
              key_reg<= key;
              cipher_reg<= cipher_text;
            end
          end
          
          init: begin
            //state_reg<=cipher_text;
            //intm_key<=key_storage[10];
            state_reg<=cipher_text_out_10;
            round_number<= 4'd9;
          end
          
          round: begin
            round_number<=round_number-1;
            //intm_key<=key_storage[round_number];
            state_reg<=cipher_text_out_round;
          end
          
          final: begin
            //intm_key<=key_storage[0];
            state_reg<=cipher_text_out_final;
            plain_text <= cipher_text_out_final;
          end
          
          finish: begin
          end
          
          default: begin
            state_reg<=128'b0;
          end
        endcase
      end
    end
    
    assign busy = (curr_state != idle && curr_state != finish);
    assign valid = (curr_state == finish);
endmodule
