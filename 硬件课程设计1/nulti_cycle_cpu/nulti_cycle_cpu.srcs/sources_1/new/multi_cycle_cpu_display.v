`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/08 15:48:00
// Design Name: 
// Module Name: multi_cycle_cpu_display
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


module multi_cycle_cpu_display(
    input clk,
    input resetn,    

    input btn_clk,


    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout[15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn
    );

    wire cpu_clk;    
	 reg btn_clk_r1;
	 reg btn_clk_r2;
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            btn_clk_r1<= 1'b0;
        end
        else
        begin
            btn_clk_r1 <= ~btn_clk;
        end

        btn_clk_r2 <= btn_clk_r1;
    end
	 
	 wire clk_en;
    assign clk_en = !resetn || (!btn_clk_r1 && btn_clk_r2);
    BUFGCE cpu_clk_cg(.I(clk),.CE(clk_en),.O(cpu_clk));

    wire [ 4:0] rf_addr;	
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
    reg	[31:0] mem_addr;	
    wire [31:0] mem_data;	
    wire [31:0] IF_pc;	
    wire [31:0] IF_inst;	
    wire [31:0] ID_pc;	
    wire [31:0] EXE_pc;	
    wire [31:0] MEM_pc;	
    wire [31:0] WB_pc;	
    wire [31:0] display_state; 
    multi_cycle_cpu cpu(
        .clk    (cpu_clk ),
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

     reg display_valid;
     reg [39:0] display_name;
     reg [31:0] display_value;
     wire [5 :0] display_number;
     wire    input_valid;
     wire [31:0] input_value; 
     lcd_module lcd_module(
        .clk    (clk    ),  //10Mhz
        .resetn (resetn ),
        .display_valid  (display_valid ),
        .display_name   (display_name   ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid    ),
        .input_value    (input_value    ),

        .lcd_rst    (lcd_rst    ),
        .lcd_cs (lcd_cs ),
        .lcd_rs (lcd_rs ),
        .lcd_wr (lcd_wr ),
        .lcd_rd (lcd_rd ),
        .lcd_data_io    (lcd_data_io    ),
        .lcd_bl_ctr (lcd_bl_ctr ),
        .ct_int (ct_int ),
        .ct_sda (ct_sda ),
        .ct_scl (ct_scl ),
        .ct_rstn    (ct_rstn    )
    );  

    always @(posedge clk)   
    begin   
        if (!resetn)    
        begin   
            mem_addr <= 32'd0;  
        end 
        else if (input_valid)   
        begin   
            mem_addr <= input_value;    
        end 
    end
    assign rf_addr = display_number-6'd11;

    always @(posedge clk)
    begin
        if (display_number >6'd10 && display_number <6'd43 )
        begin  
            display_valid <= 1'b1;
            display_name[39:16] <= "REG";
            display_name[15: 8] <= {4'b0011,3'b000,rf_addr[4]};
            display_name[7 : 0] <= {4'b0011,rf_addr[3:0]};
            case (rf_addr)
                5'd1 : display_value <= rf_data1 ;
                5'd2 : display_value <= rf_data2 ;
                5'd3 : display_value <= rf_data3 ;
                5'd4 : display_value <= rf_data4 ;
                5'd5 : display_value <= rf_data5 ;
                5'd6 : display_value <= rf_data6 ;
                5'd7 : display_value <= rf_data7 ;
                5'd8 : display_value <= rf_data8 ;
                5'd9 : display_value <= rf_data9 ;
                5'd10: display_value <= rf_data10;
                5'd11: display_value <= rf_data11;
                5'd12: display_value <= rf_data12;
                default: display_value <= 32'd0;
            endcase
        end
        else
        begin
            case(display_number)
                6'd1 :
                begin
                    display_valid <= 1'b1;
                    display_name    <= "IF_PC";
                    display_value <= IF_pc;
                end
                6'd2 : 
                begin
                    display_valid <= 1'b1;
                    display_name    <= "IF_IN";
                    display_value <= IF_inst;
                end
                6'd3 : 
                begin
                    display_valid <= 1'b1;
                    display_name    <= "ID_PC";
                    display_value <= ID_pc;
                end
                6'd4 : 
                begin
                    display_valid <= 1'b1;
                    display_name    <= "EXEPC";
                    display_value <= EXE_pc;
                end
                6'd5 : 
                begin
                    display_valid <= 1'b1;
                    display_name    <= "MEMPC";
                    display_value <= MEM_pc;
                end
                6'd6 : 
                begin
                    display_valid <= 1'b1;
                    display_name    <= "WB_PC";
                    display_value <= WB_pc;
                end
                6'd7 : 
                begin
                    display_valid <= 1'b1;
                    display_name    <= "MADDR";
                    display_value <= mem_addr;
                end
                6'd8 : 
                begin
                    display_valid <= 1'b1;
                    display_name    <= "MDATA";
                    display_value <= mem_data;
                end
                6'd9 : 
                begin
                    display_valid <= 1'b1;
                    display_name    <= "STATE";
                    display_value <= display_state;
                end 
                default :
                begin
                    display_valid <= 1'b0;
                    display_name <= 40'd0;
                    display_value <= 32'd0;
                end
            endcase
        end
    end
endmodule
