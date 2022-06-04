`timescale 1ns / 1ps
//*************************************************************************
//   > �ļ���: data_mem.v
//   > ����  ���첽���ݴ洢��ģ�飬���üĴ�������ɣ����ƼĴ�����
//   >         ͬ��д���첽��
//   > ����  : LOONGSON
//   > ����  : 2016-04-14
//*************************************************************************
module data_ram(
    input         clk,         // ʱ��
    input  [3:0]  wen,         // �ֽ�дʹ��
    input  [4:0] addr,        // ��ַ
    input  [31:0] wdata,       // д����
    output reg [31:0] rdata,       // ������
    
    //���Զ˿ڣ����ڶ���������ʾ
    input  [4 :0] test_addr,
    output reg [31:0] test_data
);
    reg [31:0] DM[31:0];  //���ݴ洢�����ֽڵ�ַ7'b000_0000~7'b111_1111

    //д����
    always @(posedge clk)    // ��д�����ź�Ϊ1������д���ڴ�
    begin
        if (wen[3])
        begin
            DM[addr][31:24] <= wdata[31:24];
        end
    end
    always @(posedge clk)
    begin
        if (wen[2])
        begin
            DM[addr][23:16] <= wdata[23:16];
        end
    end
    always @(posedge clk)
    begin
        if (wen[1])
        begin
            DM[addr][15: 8] <= wdata[15: 8];
        end
    end
    always @(posedge clk)
    begin
        if (wen[0])
        begin
            DM[addr][7 : 0] <= wdata[7 : 0];
        end
    end
    
    //������,ȡ4�ֽ�
    always @(*)
    begin
        case (addr)
            5'd0 : rdata <= DM[0 ];
            5'd1 : rdata <= DM[1 ];
            5'd2 : rdata <= DM[2 ];
            5'd3 : rdata <= DM[3 ];
            5'd4 : rdata <= DM[4 ];
            5'd5 : rdata <= DM[5 ];
            5'd6 : rdata <= DM[6 ];
            5'd7 : rdata <= DM[7 ];
            5'd8 : rdata <= DM[8 ];
            5'd9 : rdata <= DM[9 ];
            5'd10: rdata <= DM[10];
            5'd11: rdata <= DM[11];
            5'd12: rdata <= DM[12];
            5'd13: rdata <= DM[13];
            5'd14: rdata <= DM[14];
            5'd15: rdata <= DM[15];
            5'd16: rdata <= DM[16];
            5'd17: rdata <= DM[17];
            5'd18: rdata <= DM[18];
            5'd19: rdata <= DM[19];
            5'd20: rdata <= DM[20];
            5'd21: rdata <= DM[21];
            5'd22: rdata <= DM[22];
            5'd23: rdata <= DM[23];
            5'd24: rdata <= DM[24];
            5'd25: rdata <= DM[25];
            5'd26: rdata <= DM[26];
            5'd27: rdata <= DM[27];
            5'd28: rdata <= DM[28];
            5'd29: rdata <= DM[29];
            5'd30: rdata <= DM[30];
            5'd31: rdata <= DM[31];
        endcase
    end
    //���Զ˿ڣ������ض��ڴ������
    always @(*)
    begin
        case (test_addr)
            5'd0 : test_data <= DM[0 ];
            5'd1 : test_data <= DM[1 ];
            5'd2 : test_data <= DM[2 ];
            5'd3 : test_data <= DM[3 ];
            5'd4 : test_data <= DM[4 ];
            5'd5 : test_data <= DM[5 ];
            5'd6 : test_data <= DM[6 ];
            5'd7 : test_data <= DM[7 ];
            5'd8 : test_data <= DM[8 ];
            5'd9 : test_data <= DM[9 ];
            5'd10: test_data <= DM[10];
            5'd11: test_data <= DM[11];
            5'd12: test_data <= DM[12];
            5'd13: test_data <= DM[13];
            5'd14: test_data <= DM[14];
            5'd15: test_data <= DM[15];
            5'd16: test_data <= DM[16];
            5'd17: test_data <= DM[17];
            5'd18: test_data <= DM[18];
            5'd19: test_data <= DM[19];
            5'd20: test_data <= DM[20];
            5'd21: test_data <= DM[21];
            5'd22: test_data <= DM[22];
            5'd23: test_data <= DM[23];
            5'd24: test_data <= DM[24];
            5'd25: test_data <= DM[25];
            5'd26: test_data <= DM[26];
            5'd27: test_data <= DM[27];
            5'd28: test_data <= DM[28];
            5'd29: test_data <= DM[29];
            5'd30: test_data <= DM[30];
            5'd31: test_data <= DM[31];
        endcase
    end
endmodule
