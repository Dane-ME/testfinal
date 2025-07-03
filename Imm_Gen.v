module Imm_Gen (
    input  [31:0] Inst,
    output reg [31:0] Imm
);
    wire [6:0] opcode = Inst[6:0];

    always @(*) begin
        case (opcode)
            7'b0000011, // I-type
            7'b0010011,
            7'b1100111:
                Imm = {{20{Inst[31]}}, Inst[31:20]};

            7'b0100011: // S-type
                Imm = {{20{Inst[31]}}, Inst[31:25], Inst[11:7]};

            7'b1100011: // B-type
                Imm = {{19{Inst[31]}}, Inst[31], Inst[7], Inst[30:25], Inst[11:8], 1'b0};

            7'b0010111, // auipc
            7'b0110111: // lui
                Imm = {Inst[31:12], 12'b0};

            7'b1101111: // jal
                Imm = {{11{Inst[31]}}, Inst[31], Inst[19:12], Inst[20], Inst[30:21], 1'b0};

            default:
                Imm = 32'b0;
        endcase
    end
endmodule