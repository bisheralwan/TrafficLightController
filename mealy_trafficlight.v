module traffic_light_controller(red, yellow, red, car, clock, reset);
  input car;
  input clock;
  input reset;
  output reg red, yellow, green;
  
  reg [1:0] current_state, next_state;
  
  parameter [1:0] //states
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10,
    S3 = 2'b11;
  
  /* Next State Logic ---> Clock ---> Output Logic */
  always @(posedge clock or posedge reset)
    begin
      if (reset)
        current_state <= S0;
      else
        current_state <= next_state;
    end
  
  always @(*)
    begin
      red = 0; yellow = 0; green = 0;
      case(current_state)
        S0:
          if (car)
            yellow = 1;
            next_state = S1;
          else
            red = 1;
            next_state = S0;
        S1:
          green = 1;
          next_state = S2;
        S2:
          red = 1;
          next_state = S0;
      endcase
    end
endmodule
