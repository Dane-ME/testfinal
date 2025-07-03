module riscv_single_cycle(
    input logic clk,
    input logic rst_n,
    output logic [31:0] pc_out,
    output logic [31:0] instruction_out
);

    // Program Counter
    logic [31:0] pc_next;

    // Wires for instruction fields
    logic [4:0] rs1, rs2, rd;
    logic [2:0] funct3;
    logic [6:0] opcode, funct7;

    // Immediate value
    logic [31:0] imm;

    // Register file wires
    logic [31:0] read_data1, read_data2, write_data;

    // ALU
    logic [31:0] alu_in2, alu_result;
    logic alu_zero;

    // Data Memory
    logic [31:0] mem_read_data;

    // Control signals
    logic [1:0] alu_src;
    logic [3:0] alu_ctrl;
    logic branch, mem_read, mem_write, mem_to_reg;
    logic reg_write, pc_sel;

    // PC update
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pc_out <= 32'b0;
        else
            pc_out <= pc_next;
    end

    // Instruction Memory (IMEM)
    imem imem_inst(
        .addr(pc_out),
        .instruction(instruction_out)
    );

    // Instruction field decoding
    assign opcode = instruction_out[6:0];
    assign rd     = instruction_out[11:7];
    assign funct3 = instruction_out[14:12];
    assign rs1    = instruction_out[19:15];
    assign rs2    = instruction_out[24:20];
    assign funct7 = instruction_out[31:25];

    // Immediate generator
    imm_gen imm_gen_inst(
        .inst(instruction_out),
        .imm_out(imm)
    );

    // Register File (instance name must be reg_file_inst for tb)
    register_file reg_file_inst(
        .clk(clk),
        .rst_n(rst_n),
        .reg_write(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // ALU input selection
    assign alu_in2 = (alu_src[0]) ? imm : read_data2;

    // ALU
    alu alu_inst(
        .a(read_data1),
        .b(alu_in2),
        .alu_op(alu_ctrl),
        .result(alu_result),
        .zero(alu_zero)
    );

    // Data Memory (DMEM)
    dmem dmem_inst(
        .clk(clk),
        .rst_n(rst_n),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(read_data2),
        .read_data(mem_read_data)
    );

    // Write-back mux
    assign write_data = (mem_to_reg) ? mem_read_data : alu_result;

    // Control unit
    control_unit ctrl_inst(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .alu_src(alu_src),
        .alu_op(alu_ctrl),
        .branch(branch),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write)
    );

    // Branch comparator
    branch_comp branch_comp_inst(
        .a(read_data1),
        .b(read_data2),
        .branch(branch),
        .funct3(funct3),
        .br_taken(pc_sel)
    );

    // Next PC logic
    assign pc_next = (pc_sel) ? pc_out + imm : pc_out + 4;

endmodule
