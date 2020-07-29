`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 13:10:33
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
    input H_sync,
    input [23:0]rgb_data,
    output rgb_led
    );
    reg [7:0]R_In=0;
    reg [7:0]G_In=0;
    reg [7:0]B_In=0;
    reg [15:0]h_cnt=0;
    Driver_SK6805_0 rgb0(
    .R_In1(R_In),
    .G_In1(G_In),
    .B_In1(B_In),
    .R_In2(R_In),
    .G_In2(G_In),
    .B_In2(B_In),
    .clk_10MHz(clk_10MHz),
    .Rst(1),
    .LED_IO(rgb_led)
    );
    always@(posedge H_sync)
        begin 
            if(h_cnt==115|h_cnt==295|h_cnt==475|h_cnt==655)
                begin
                    R_In<=rgb_data[23:16];
                    G_In<=rgb_data[15:8];
                    B_In<=rgb_data[7:0];
                    h_cnt<=h_cnt+1;
                end
            else if(h_cnt==749)
                h_cnt<=0;
            else 
                h_cnt<=h_cnt+1;
        end
endmodule
