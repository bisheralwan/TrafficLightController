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
  
  /* Next State Logic */
  always @(posedge clock or posedge reset)
    begin
      if (reset)
        current_state <= S0; //reset state if reset is high
      else
        current_state <= next_state;
    end
  
  /* Output Logic */
  always @(car or current_state)
    begin
      red = 0; yellow = 0; green = 0; //defaults to prevent latches
      case (current_state)
        S0:
          begin
            red = 1;
            if (car)
              next_state = S1;
            else
              next_state = current_state;
          end
        S1:
          begin
            yellow = 1;
            next_state = S2;
          end
        S2:
          begin
            green = 1;
            next_state = S0;
          end
        default: //if we arrive at default, we are at an illegal state and therefore must return to base state
          begin
            next_state = S0;
          end
      endcase
    end 
        
 endmodule
