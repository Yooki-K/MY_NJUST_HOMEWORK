`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/08 18:04:09
// Design Name: 
// Module Name: data_ram
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

//*************************************************************************
//   > 文件名: data_ram.v
//   > 描述  ：异步数据存储器模块，采用寄存器搭建而成，类似寄存器堆
//   >         同步写，异步读
//   > 作者  : LOONGSON
//   > 日期  : 2016-04-14
//*************************************************************************
module data_ram(
    input         clka,         // 时钟
    input  [3:0]  wea,         // 字节写使能
    input  [7:0] addra,        // 地址
    input  [31:0] dina,       // 写数据
    output reg [31:0] douta,       // 读数据
    
    //调试端口，用于读出数据显示
    input         clkb,         // 时钟
    input  [3:0]  web,         // 字节写使能
    input  [7:0] addrb,        // 地址
    input  [31:0] dinb,       // 写数据
    output reg [31:0] doutb       // 读数据
);
    reg [31:0] DM[31:0];  //数据存储器，字节地址7'b000_0000~7'b111_1111

    //写数据
    always @(posedge clka)    // 当写控制信号为1，数据写入内存
    begin
        if (wea[3])
        begin
            DM[addra][31:24] <= dina[31:24];
        end
    end
    always @(posedge clka)
    begin
        if (wea[2])
        begin
            DM[addra][23:16] <= dina[23:16];
        end
    end
    always @(posedge clka)
    begin
        if (wea[1])
        begin
            DM[addra][15: 8] <= dina[15: 8];
        end
    end
    always @(posedge clka)
    begin
        if (wea[0])
        begin
            DM[addra][7 : 0] <= dina[7 : 0];
        end
    end
    
    //读数据,取4字节
    always @(posedge clka)
    begin
        case (addra)
            5'd0 : douta <= DM[0 ];
            5'd1 : douta <= DM[1 ];
            5'd2 : douta <= DM[2 ];
            5'd3 : douta <= DM[3 ];
            5'd4 : douta <= DM[4 ];
            5'd5 : douta <= DM[5 ];
            5'd6 : douta <= DM[6 ];
            5'd7 : douta <= DM[7 ];
            5'd8 : douta <= DM[8 ];
            5'd9 : douta <= DM[9 ];
            5'd10: douta <= DM[10];
            5'd11: douta <= DM[11];
            5'd12: douta <= DM[12];
            5'd13: douta <= DM[13];
            5'd14: douta <= DM[14];
            5'd15: douta <= DM[15];
            5'd16: douta <= DM[16];
            5'd17: douta <= DM[17];
            5'd18: douta <= DM[18];
            5'd19: douta <= DM[19];
            5'd20: douta <= DM[20];
            5'd21: douta <= DM[21];
            5'd22: douta <= DM[22];
            5'd23: douta <= DM[23];
            5'd24: douta <= DM[24];
            5'd25: douta <= DM[25];
            5'd26: douta <= DM[26];
            5'd27: douta <= DM[27];
            5'd28: douta <= DM[28];
            5'd29: douta <= DM[29];
            5'd30: douta <= DM[30];
            5'd31: douta <= DM[31];
        endcase
    end
    //调试端口，读出特定内存的数据
    always @(posedge clkb)
    begin
        case (addrb)
            5'd0 : doutb <= DM[0 ];
            5'd1 : doutb <= DM[1 ];
            5'd2 : doutb <= DM[2 ];
            5'd3 : doutb <= DM[3 ];
            5'd4 : doutb <= DM[4 ];
            5'd5 : doutb <= DM[5 ];
            5'd6 : doutb <= DM[6 ];
            5'd7 : doutb <= DM[7 ];
            5'd8 : doutb <= DM[8 ];
            5'd9 : doutb <= DM[9 ];
            5'd10: doutb <= DM[10];
            5'd11: doutb <= DM[11];
            5'd12: doutb <= DM[12];
            5'd13: doutb <= DM[13];
            5'd14: doutb <= DM[14];
            5'd15: doutb <= DM[15];
            5'd16: doutb <= DM[16];
            5'd17: doutb <= DM[17];
            5'd18: doutb <= DM[18];
            5'd19: doutb <= DM[19];
            5'd20: doutb <= DM[20];
            5'd21: doutb <= DM[21];
            5'd22: doutb <= DM[22];
            5'd23: doutb <= DM[23];
            5'd24: doutb <= DM[24];
            5'd25: doutb <= DM[25];
            5'd26: doutb <= DM[26];
            5'd27: doutb <= DM[27];
            5'd28: doutb <= DM[28];
            5'd29: doutb <= DM[29];
            5'd30: doutb <= DM[30];
            5'd31: doutb <= DM[31];
        endcase
    end
endmodule

