module Branch_Comp (
    input  [31:0] A,
    input  [31:0] B,
    input  Branch,
    input  [2:0] funct3,
    output reg BrTaken
);
    always @(*) begin
        BrTaken = 0;
        if (Branch) begin
            case (funct3)
                3'b000: BrTaken = (A == B);         // beq
                3'b001: BrTaken = (A != B);         // bne
                3'b100: BrTaken = ($signed(A) < $signed(B)); // blt
                3'b101: BrTaken = ($signed(A) >= $signed(B)); // bge
                3'b110: BrTaken = (A < B);          // bltu
                3'b111: BrTaken = (A >= B);         // bgeu
                default: BrTaken = 0;
            endcase
        end
    end
endmodule