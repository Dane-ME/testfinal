# RISC-V Single Cycle Processor

## Mô tả dự án
Đây là một thiết kế bộ xử lý RISC-V single cycle được viết bằng SystemVerilog, hỗ trợ các lệnh cơ bản của RISC-V ISA.

## Cấu trúc dự án

### Các module chính:
- **riscv_single_cycle.v** - Module top-level của bộ xử lý
- **alu.v** - Arithmetic Logic Unit
- **control_unit.v** - Đơn vị điều khiển
- **register_file.v** - Bộ thanh ghi 32x32-bit
- **imem.v** - Instruction Memory
- **dmem.v** - Data Memory
- **imm_gen.v** - Immediate Generator
- **branch_comp.v** - Branch Comparator
- **alu_decoder.v** - ALU Decoder (không sử dụng trong thiết kế hiện tại)

## Quy chuẩn đặt tên (Naming Convention)

### Đã được chuẩn hóa theo SystemVerilog best practices:

#### 1. **File names**: `snake_case.v`
- ✅ `riscv_single_cycle.v` (trước: `RISCV_Single_Cycle.v`)
- ✅ `register_file.v` (trước: `RegisterFile.v`)
- ✅ `branch_comp.v` (trước: `Branch_Comp.v`)
- ✅ `alu.v` (trước: `ALU.v`)
- ✅ `imem.v` (trước: `IMEM.v`)
- ✅ `dmem.v` (trước: `DMEM.v`)
- ✅ `imm_gen.v` (trước: `Imm_Gen.v`)
- ✅ `alu_decoder.v` (trước: `ALU_decoder.v`)
- ✅ `control_unit.v` (đã đúng từ trước)

#### 2. **Module names**: `snake_case`
- ✅ `riscv_single_cycle` (trước: `RISCV_Single_Cycle`)
- ✅ `register_file` (trước: `RegisterFile`)
- ✅ `branch_comp` (trước: `Branch_Comp`)
- ✅ `alu` (trước: `ALU`)
- ✅ `imem` (trước: `IMEM`)
- ✅ `dmem` (trước: `DMEM`)
- ✅ `imm_gen` (trước: `Imm_Gen`)
- ✅ `alu_decoder` (trước: `ALU_decoder`)

#### 3. **Signal names**: `snake_case`
- ✅ `pc_out` (trước: `PC_out_top`)
- ✅ `instruction_out` (trước: `Instruction_out_top`)
- ✅ `read_data1, read_data2` (trước: `ReadData1, ReadData2`)
- ✅ `write_data` (trước: `WriteData`)
- ✅ `alu_result` (trước: `ALU_result`)
- ✅ `alu_zero` (trước: `ALUZero`)
- ✅ `mem_read_data` (trước: `MemReadData`)
- ✅ `alu_src` (trước: `ALUSrc`)
- ✅ `alu_ctrl` (trước: `ALUCtrl`)
- ✅ `mem_read, mem_write` (trước: `MemRead, MemWrite`)
- ✅ `mem_to_reg` (trước: `MemToReg`)
- ✅ `reg_write` (trước: `RegWrite`)
- ✅ `pc_sel` (trước: `PCSel`)
- ✅ `br_taken` (trước: `BrTaken`)

#### 4. **Instance names**: `snake_case` với suffix mô tả
- ✅ `imem_inst` (trước: `IMEM_inst`)
- ✅ `dmem_inst` (trước: `DMEM_inst`)
- ✅ `reg_file_inst` (trước: `Reg_inst`)
- ✅ `alu_inst` (trước: `alu`)
- ✅ `ctrl_inst` (trước: `ctrl`)
- ✅ `branch_comp_inst` (trước: `comp`)
- ✅ `imm_gen_inst` (trước: `imm_gen`)

#### 5. **Coding style improvements**:
- ✅ Sử dụng `always_comb` thay vì `always @(*)`
- ✅ Thống nhất sử dụng `logic` thay vì `reg` cho internal signals
- ✅ Cải thiện comments và formatting

## Các lệnh được hỗ trợ

### R-type instructions:
- ADD, SUB, AND, OR, XOR
- SLL, SRL, SRA
- SLT, SLTU

### I-type instructions:
- ADDI, ANDI, ORI, XORI
- SLLI, SRLI, SRAI
- SLTI, SLTIU
- Load instructions (LW)

### S-type instructions:
- Store instructions (SW)

### B-type instructions:
- BEQ, BNE, BLT, BGE, BLTU, BGEU

### J-type instructions:
- JAL, JALR (cần cải thiện thêm)

## Cải thiện đã thực hiện

1. **Naming Convention**: Chuẩn hóa tất cả tên file, module, signal theo snake_case
2. **Code Style**: Sử dụng `always_comb` và `logic` type
3. **Consistency**: Thống nhất naming pattern cho tất cả instance names
4. **Documentation**: Thêm comments và README

## Các cải thiện tiếp theo cần thực hiện

1. **Sửa lỗi JAL/JALR**: Cần thêm logic để lưu PC+4 vào register
2. **Thêm LUI/AUIPC**: Cần thêm hỗ trợ trong control unit
3. **Memory files**: Tạo thư mục mem/ với các file test
4. **Testbench**: Tạo testbench để kiểm tra hoạt động
5. **Exception handling**: Thêm xử lý lỗi và invalid instructions

## Cách sử dụng

1. Compile tất cả các file .v
2. Tạo thư mục `mem/` với các file:
   - `imem.hex` hoặc `imem2.hex` - chứa instructions
   - `dmem_init.hex` hoặc `dmem_init2.hex` - khởi tạo data memory
3. Chạy simulation với module `riscv_single_cycle`

## Tác giả
- Dự án gốc: RISC-V Single Cycle CK
- Cải thiện naming convention: 2025
