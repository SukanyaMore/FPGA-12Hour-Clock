`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2022 16:26:01
// Design Name: 
// Module Name: digitalClock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module digitalClock(
    input clk, // 100 MHz
    input ctr, //to switch on or switch off clock mode 
    input rgt, //to change from minute to hour and hour to minute
    input lft, //to change from minute to hour and hour to minute
    input up, //to increment hrs or min
    input dn, //to decrement hrs or min
    output [6:0] segment, 
    output [3:0] enable, 
    output AM_PMled,
    output clock_modeled //to know the clock  mode
    );
  
    reg [31:0] count =0; 
    parameter max_count=100_000_000; 
    
    //initializing some variables
    reg [5:0] hours, mintes, seconds = 0;//12 hour clock
    reg [3:0] zero_min, first_min, zero_hour, first_hour = 0; 
    reg change = 0; //to change, 0 - minutes, 1 - hours
    
    reg PM = 0;
    assign AM_PMled = PM;
    reg clock_mode = 0;
    assign clock_modeled = clock_mode;
    Seven_Segment SSM(clk, zero_min, first_min, zero_hour, first_hour , segment, enable);
    
//To start the clock first need to push center button
   parameter clk_time = 1'b0;
   parameter set_time = 1'b1;
   reg current_time = set_time;
   
   //logic to increameny second by 1
   always @(posedge clk) begin
        case(current_time)
            clk_time: begin 
                if (ctr) begin 
                    clock_mode <= 0;
                    current_time <= set_time; 
                    count <= 0;
                    change <= 0;
                    seconds <= 0; 
                end
                
                if (count <max_count) begin // time
                    count <= count + 1;
                end else begin
                    count <= 0;
                    seconds <= seconds + 1;
                end                                
            end 
   

        //logic for miutes and hours
            set_time: begin
                if (ctr) begin 
                    clock_mode <= 1;
                    current_time <= clk_time;
                end
                
                if (count < (25_000_000)) begin 
                    count <= count + 1;
                end else begin
                    count <= 0;
                    case (change)
                        1'b0: begin 
                            if (up) begin 
                                mintes <= mintes + 1;
                            end
                            if (dn) begin 
                                if (mintes > 0) begin
                                    mintes <= mintes - 1;
                                end else if (hours > 1) begin 
                                    hours <= hours - 1;
                                    mintes <= 59;
                                end else if (hours == 1) begin
                                    hours <= 12;
                                    mintes <= 59;
                                end
                            end
     
                            if (lft || rgt) begin 
                                change <= 1;
                            end
                        end 
                        
                        1'b1: begin 
                            if (up) begin 
                                hours <= hours + 1;
                            end
                            if (dn) begin 
                                if (hours > 1) begin
                                    hours <= hours - 1;
                                end else if (hours == 1) begin 
                                    hours <= 12;
                                    //AM_PM <= ~AM_PM;
                                end
                            end
                            if (rgt || lft) begin 
                                change <= 0;
                            end
                        end                      
                endcase               
                end                    
            end 
        endcase // end case(Current_Mode)
     
 //Digital Clock 12hr_format
        if (seconds >= 60) begin // After 60 seconds, increment minutes
                seconds <= 0;
                mintes <= mintes + 1;
        end
        if (mintes >= 60) begin // After 60 minutes, increment hours
                mintes <= 0;
                hours <= hours + 1;
        end
        if (hours >= 24) begin // After 12 hours, swap between AM and PM
            hours <= 0;
        end


//AM/PM Time
        else begin             
            zero_min <= mintes % 10;  
            first_min <= mintes / 10;  
            if (hours < 12) begin
                if (hours == 0) begin 
                    zero_hour <= 2;
                    first_hour <= 1;
                end else begin
                    zero_hour <= hours % 10;    
                    first_hour <= hours / 10;    
                end
                PM <= 0;
            end else begin 
                if (hours == 12) begin 
                    zero_hour <= 2;
                    first_hour <= 1;
                end else begin
                    zero_hour <= (hours - 12) % 10;    
                    first_hour <= (hours - 12) / 10;    
                end
                PM <= 1;                        
            end              
        end 
    end 


    
endmodule

    
