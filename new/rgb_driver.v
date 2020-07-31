`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 15:26:50
// Design Name: 
// Module Name: rgb_driver
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



module rgb_driver(
    input clk_10MHz,
    input i_rst,
    input [10:0]set_x,
    input [9:0]set_y,
    input [23:0]rgb_data,
    output rgb_led
    );
    reg [7:0]R_In=0;
    reg [7:0]G_In=0;
    reg [7:0]B_In=0;
    reg [6:0]cnt1=0;
    reg [3:0]cnt=0;
    
    Driver_SK6805_0 rgb0(
    .R_In1(R_In),
    .G_In1(G_In),
    .B_In1(B_In),
    .R_In2(0),
    .G_In2(0),
    .B_In2(0),
    .clk_10MHz(clk_10MHz),
    .Rst(i_rst),
    .LED_IO(rgb_led)
    );
    always@(*)
        begin 
            if(set_x==640&set_y==360)
                begin
                    cnt1<=cnt1+1;
                    if(cnt1==120)
                        begin
                            R_In<=rgb_data[23:16];
                            B_In<=rgb_data[15:8];
                            G_In<=rgb_data[7:0];
                            cnt1<=0;
                        end
                    else
                        begin
                            R_In<=R_In;
                            B_In<=B_In;
                            G_In<=G_In;
                        end
                end
            else 
                begin
                    R_In<=R_In;
                    B_In<=B_In;
                    G_In<=G_In;
                end
        end
endmodule
