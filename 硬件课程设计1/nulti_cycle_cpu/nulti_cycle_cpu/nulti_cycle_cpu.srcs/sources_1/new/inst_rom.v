`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/08 18:04:09
// Design Name: 
// Module Name: inst_rom
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
//   > 文件名: inst_rom.v
//   > 描述  ：同步指令存储器模块，采用寄存器搭建而成，类似寄存器堆
//   >         内嵌好指令，只读，同步读
//   > 作者  : KY
//   > 日期  : 2022-06-07
//*************************************************************************
module inst_rom(
    input      clka,
    input      [7:0] addra, // 指令地址
    output reg [31:0] douta       // 指令
    );

    wire [31:0] inst_rom[29:0];  // 指令存储器，字节地址7'b000_0000~7'b111_1111
    //------------- 指令编码 ---------|指令地址|--- 汇编指令 -----|- 指令结果 -----//
    assign inst_rom[ 0] = 32'h24010001; // 00H: addiu $1 ,$0,#1   | $1 = 0000_0001H
    assign inst_rom[ 1] = 32'h00011100; // 04H: sll   $2 ,$1,#4   | $2 = 0000_0010H
    assign inst_rom[ 2] = 32'h00411821; // 08H: addu  $3 ,$2,$1   | $3 = 0000_0011H
    assign inst_rom[ 3] = 32'h00022082; // 0CH: srl   $4 ,$2,#2   | $4 = 0000_0004H
    assign inst_rom[ 4] = 32'h00642823; // 10H: subu  $5 ,$3,$4   | $5 = 0000_000DH
    assign inst_rom[ 5] = 32'hAC250013; // 14H: sw    $5 ,#19($1) | Mem[0000_0014H] = 0000_000DH
    assign inst_rom[ 6] = 32'h00A23027; // 18H: nor   $6 ,$5,$2   | $6 = FFFF_FFE2H
    assign inst_rom[ 7] = 32'h00C33825; // 1CH: or    $7 ,$6,$3   | $7 = FFFF_FFF3H
    assign inst_rom[ 8] = 32'h00E64026; // 20H: xor   $8 ,$7,$6   | $8 = 0000_0011H
    assign inst_rom[ 9] = 32'hAC08001C; // 24H: sw    $8 ,#28($0) | Mem[0000_001CH] = 0000_0011H
    assign inst_rom[10] = 32'h00C7482A; // 28H: slt   $9 ,$6,$7   | $9 = 0000_0001H
    assign inst_rom[11] = 32'h11210002; // 2CH: beq   $9 ,$1,#2   | 相等则跳转到指令34H
    assign inst_rom[12] = 32'h24010004; // 30H: addiu $1 ,$0,#4   | 不执行
    assign inst_rom[13] = 32'h00845004; // 34H: lw    $10,#19($1) | $10 = 0000_000DH
    assign inst_rom[14] = 32'h01400008; // 38H: bne   $10,$5,#3   | 不跳转
    assign inst_rom[15] = 32'h24010002; // 3CH: and   $11,$2,$1   | $11 = 0000_0000H
    assign inst_rom[16] = 32'h00415825; // 40H: or   $11,$2,$1   | $11 = 0001_0001H
    assign inst_rom[17] = 32'hAC07001C; // 44H: sw    $11,#28($0) | Men[0000_001CH] = 0000_0000H
    assign inst_rom[18] = 32'h00265807; // 48H: sw    $4 ,#16($0) | Mem[0000_0010H] = 0000_0004H
    assign inst_rom[19] = 32'h3C0C000C; // 4CH: lui   $12,#12     | [R12] = 000C_0000H
    assign inst_rom[20] = 32'h00265806; // 50H: lui   $12,#12     | [R12] = 000C_0000H
    assign inst_rom[21] = 32'h24010002; // 54H: lui   $12,#12     | [R12] = 000C_0000H
    assign inst_rom[22] = 32'h00211024; // 58H: lui   $12,#12     | [R12] = 000C_0000H
    assign inst_rom[23] = 32'h3403000A; // 5CH: lui   $12,#12     | [R12] = 000C_0000H
    assign inst_rom[24] = 32'h10430004; // 60H: lui   $12,#12     | [R12] = 000C_0000H
    assign inst_rom[25] = 32'h00010840; // 64H: lui   $12,#12     | [R12] = 000C_0000H
    assign inst_rom[26] = 32'h24420001; // 68H: lui   $12,#12     | [R12] = 000C_0000H
    assign inst_rom[27] = 32'h08000018; // 6CH: lui   $12,#12     | [R12] = 000C_0000H
    assign inst_rom[28] = 32'hAC01001C; // 70H: lui   $12,#12     | [R12] = 000C_0000H
    assign inst_rom[29] = 32'h08000000; // 74H: j     00H         | 跳转指令00H

    //读指令,取4字节
    always @(posedge clka)
    begin
        case (addra)
            5'd0 : douta <= inst_rom[0 ];
            5'd1 : douta <= inst_rom[1 ];
            5'd2 : douta <= inst_rom[2 ];
            5'd3 : douta <= inst_rom[3 ];
            5'd4 : douta <= inst_rom[4 ];
            5'd5 : douta <= inst_rom[5 ];
            5'd6 : douta <= inst_rom[6 ];
            5'd7 : douta <= inst_rom[7 ];
            5'd8 : douta <= inst_rom[8 ];
            5'd9 : douta <= inst_rom[9 ];
            5'd10: douta <= inst_rom[10];
            5'd11: douta <= inst_rom[11];
            5'd12: douta <= inst_rom[12];
            5'd13: douta <= inst_rom[13];
            5'd14: douta <= inst_rom[14];
            5'd15: douta <= inst_rom[15];
            5'd16: douta <= inst_rom[16];
            5'd17: douta <= inst_rom[17];
            5'd18: douta <= inst_rom[18];
            5'd19: douta <= inst_rom[19];
            5'd20: douta <= inst_rom[20];
            5'd21: douta <= inst_rom[21];
            5'd22: douta <= inst_rom[22];
            5'd23: douta <= inst_rom[23];
            5'd24: douta <= inst_rom[24];
            5'd25: douta <= inst_rom[25];
            5'd26: douta <= inst_rom[26];
            5'd27: douta <= inst_rom[27];
            5'd28: douta <= inst_rom[28];
            5'd29: douta <= inst_rom[29];
            default: douta <= 32'd0;
        endcase
    end
endmodule
