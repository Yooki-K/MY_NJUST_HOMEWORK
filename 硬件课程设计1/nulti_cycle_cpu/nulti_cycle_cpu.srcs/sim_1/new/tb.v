`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/09 18:20:46
// Design Name: 
// Module Name: tb
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

module tb;

    // Inputs
    reg clk;
    reg resetn;
    reg [4:0] rf_addr;
    reg [31:0] mem_addr;

    // Outputs
    wire [31:0] rf_data1;
    wire [31:0] rf_data2;
    wire [31:0] rf_data3;
    wire [31:0] rf_data4;
    wire [31:0] rf_data5;
    wire [31:0] rf_data6;
    wire [31:0] rf_data7;
    wire [31:0] rf_data8;
    wire [31:0] rf_data9;
    wire [31:0] rf_data10;
    wire [31:0] rf_data11;
    wire [31:0] rf_data12;
    wire [31:0] mem_data;	//内存地址对应的数据
    wire [31:0] IF_pc;	//IF 模块的 PC
    wire [31:0] IF_inst;	//IF 模块取出的指令
    wire [31:0] ID_pc;	//ID 模块的 PC
    wire [31:0] EXE_pc;	//EXE 模块的 PC
    wire [31:0] MEM_pc;	//MEM 模块的 PC
    wire [31:0] WB_pc;	//WB 模块的 PC
    wire [31:0] display_state; //展示 CPU 当前状态
    
    multi_cycle_cpu cpu(
        .clk    (clk ),
        .resetn (resetn ), 
        .rf_addr (rf_addr ),
        .mem_addr(mem_addr),
        .rf_data1 (rf_data1),
        .rf_data2 (rf_data2),
        .rf_data3 (rf_data3),
        .rf_data4 (rf_data4),
        .rf_data5 (rf_data5),
        .rf_data6 (rf_data6),
        .rf_data7 (rf_data7),
        .rf_data8 (rf_data8),
        .rf_data9 (rf_data9),
        .rf_data10 (rf_data10),
        .rf_data11 (rf_data11),
        .rf_data12 (rf_data12),
        .mem_data(mem_data),
        .IF_pc  (IF_pc  ),
        .IF_inst (IF_inst ),
        .ID_pc  (ID_pc  ),
        .EXE_pc (EXE_pc ),
        .MEM_pc (MEM_pc ),
        .WB_pc  (WB_pc  ),
        .display_state (display_state) 
    );
    initial begin
        // Initialize Inputs
        clk = 0;
        resetn = 0;
        rf_addr = 'hB;
        mem_addr = 'h1C;

        // Wait 100 ns for global reset to finish
        #5;
      resetn = 1;
        // Add stimulus here
    end
    always #1 clk=~clk;
endmodule


