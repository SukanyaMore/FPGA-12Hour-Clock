module Seven_Segment(
    input clk, //100MHz
    input [3:0] zero_min,
    input [3:0] first_min,
    input [3:0] zero_hour,
    input [3:0] first_hour,
    output reg [6:0] segment,
    output reg [3:0] enable
    );
    //
    reg [1:0] digit_clk = 0;
    reg [6:0] display_clk [3:0];
    
    reg [18:0] count = 0;
    parameter max_count = 500_000; //half frequency
    wire [3:0] no_to_be_display [3:0];
  
    //assigning values to minutes and hours digits 
      assign no_to_be_display[0] = zero_min;
      assign no_to_be_display[1] = first_min;
      assign no_to_be_display[2] = zero_hour;
      assign no_to_be_display[3] = first_hour;
  
  //slow clk
  
        always @(posedge clk) begin                  
        if (count < max_count) begin
            count <= count+1;
        end else begin
            digit_clk <= digit_clk + 1;
            count <= 0;
        end
   //basys 3 board has active low logic
   
   //converting BCD to seven segment display for clock to  be display on FPGA
     case(no_to_be_display[digit_clk]) 
			 4'b0000 : display_clk[digit_clk] <= 7'b1000000; //0
			 4'b0001 : display_clk[digit_clk] <= 7'b1111001; //1
			 4'b0010 : display_clk[digit_clk] <= 7'b0100100; //2
			 4'b0011 : display_clk[digit_clk] <= 7'b0110000; //3
			 4'b0100 : display_clk[digit_clk] <= 7'b0011001; //4
			 4'b0101 : display_clk[digit_clk] <= 7'b0010010; //5
			 4'b0110 : display_clk[digit_clk] <= 7'b0000010; //6
			 4'b0111 : display_clk[digit_clk] <= 7'b1111000; //7
			 4'b1000 : display_clk[digit_clk] <= 7'b0000000; //8
			 4'b1001 : display_clk[digit_clk] <= 7'b0011000; //9

		 endcase


        if(digit_clk==0) 
        begin  
        enable <= 4'b1110; //enabling zero_min
        segment <= display_clk[0];  
        end
        else if(digit_clk==1) 
        begin  
        enable <= 4'b1101; //enabling first_min
        segment <= display_clk[1];  
        end
        else if(digit_clk==2) 
        begin  
        enable <= 4'b1011; //enabling zero_hour
        segment <= display_clk[2];  
        end
        else if(digit_clk==3) 
        begin  
        enable <= 4'b0111; //enabling first_hour
        segment <= display_clk[3];  
        end
    end 
endmodule

   

