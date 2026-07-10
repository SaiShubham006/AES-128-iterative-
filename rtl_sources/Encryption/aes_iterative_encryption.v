module aes_iterative(
  input clk,
  input reset,
  input [127:0] plain_text,
  input [127:0] key,
  input start,
  output reg [127:0] cipher_text,
  output reg valid,
  output reg busy
    );
    
    reg [127:0] state;
    wire [127:0] round_out;
    reg [3:0] round_number;
    wire [127:0] final_round_out;
    wire [127:0] interm_key_out;
    reg [127:0] interm_key;
    
    reg [2:0] curr_state, next_state;
    localparam [2:0] idle=3'b000;
    localparam [2:0] init=3'b001;
    localparam [2:0] round=3'b010;
    localparam [2:0] final=3'b011;
    localparam [2:0] finish=3'b100;
    
    aes_round i1(state, interm_key_out, round_out);
    final_round i2(state, interm_key_out, final_round_out);
    keyExpansion i4(interm_key, round_number, interm_key_out);
        
    wire [127:0] round0_out;
    addRoundKey i3(plain_text, key, round0_out);
    
    always@(posedge clk or negedge reset) begin
    if(!reset) begin
      curr_state<=idle;
      state <= 128'b0;
      round_number <= 4'b0;
      interm_key <= 128'b0;
      cipher_text <= 128'b0;
      end
      else begin 
      curr_state<=next_state;
      
      case (curr_state)
      
        init: begin
          state<=round0_out;
          round_number<=4'b0001;
          interm_key<=key;
        end
        
        round: begin
          state<=round_out;
          round_number<=round_number+1;
          interm_key<=interm_key_out;
        end
        
        final: begin
          //interm_key<=interm_key_out;
          cipher_text<=final_round_out;          
        end 
        
        finish: begin

        end
        
        default: begin
          state<=128'b0;
          round_number<=4'b0;
          interm_key<=128'b0;
          cipher_text<=128'b0;
        end
      endcase   
    end
  end  
    always@(*) begin
      case(curr_state)
        idle: begin
          if(start) next_state=init;
          else next_state=idle;
        end
        
        init: begin
          next_state=round;
        end
        
        round: begin
          if(round_number==4'd9) next_state=final;
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
    
    always@(posedge clk or negedge reset) begin
    if(!reset) begin
      valid <= 1'b0;
      busy  <= 1'b0;
    end
    else begin

      case(curr_state)

      idle: begin
        valid <= 1'b0;
        busy  <= 1'b0;
       end

       init, round, final: begin
        valid <= 1'b0;
        busy  <= 1'b1;
      end

      finish: begin
        valid <= 1'b1;
        busy  <= 1'b0;
      end

      default: begin
        valid <= 1'b0;
        busy  <= 1'b0;
      end
    endcase
    end
    end
endmodule
