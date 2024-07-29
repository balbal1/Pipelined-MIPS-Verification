package instruction_pkg;

class Instruction;

    typedef enum bit [5:0] {
        And     = 6'b100100,
        Or      = 6'b100101,
        Nor     = 6'b100111,
        Xor     = 6'b100110,
        add     = 6'b100000,
        addu    = 6'b100001,
        sub     = 6'b100010,
        slt     = 6'b101010,
        sltu    = 6'b101011,
        sll     = 6'b000000,
        sllv    = 6'b000100,
        sra     = 6'b000011,
        srav    = 6'b000111,
        srl     = 6'b000010,
        srlv    = 6'b000110,
        divu    = 6'b011011,
        jr      = 6'b001000,
        jalr    = 6'b001001
    } R_instructions;

    typedef enum bit [5:0] {
        andi 	= 6'b001100,
        ori 	= 6'b001101,
        xori 	= 6'b001110,
        addi 	= 6'b001000,
        addiu 	= 6'b001001,
        lui 	= 6'b001111,
        sltiu 	= 6'b001011,
        slti 	= 6'b001010,
        beq 	= 6'b000100,
        bne 	= 6'b000101,
        bgez 	= 6'b000001,
        sw 		= 6'b101011,
        sh 		= 6'b101001,
        sb 		= 6'b101000,
        lw 		= 6'b100011,
        lh 		= 6'b100001,
        lhu 	= 6'b100101,
        lb 		= 6'b100000,
        lbu 	= 6'b100100
    } I_instructions;

    typedef enum bit [5:0] {
        j 		= 6'b000010,
        jal 	= 6'b000011
    } J_instructions;

    typedef enum bit [1:0] {R_type, I_type, J_type} types;

    types instruction_type;
    rand types rand_instruction_type;

    rand I_instructions i_op_code;
    rand J_instructions j_op_code;
    rand bit [4:0] rs, rt, rd;
    rand bit [4:0] shmat;
    rand R_instructions funct;
    rand bit [15:0] immediate;
    rand bit [25:0] address;
    bit [31:0] instruction_word;

    function generate_type (bit [1:0] instruction_type = 0);
        if (instruction_type == 0) begin
            this.instruction_type = this.rand_instruction_type;
        end else if (instruction_type == 1) begin
            this.instruction_type = R_type;
        end else if (instruction_type == 2) begin
            this.instruction_type = I_type;
        end else if (instruction_type == 3) begin
            this.instruction_type = J_type;
        end
    endfunction

    function generate_word ();
        if (this.instruction_type == R_type) begin
            this.instruction_word = {6'd0, rs, rt, rd, shmat, funct};
        end else if (instruction_type == I_type) begin
            this.instruction_word = {i_op_code, rs, rt, immediate};
        end else if (instruction_type == J_type) begin
            this.instruction_word = {j_op_code, address};
        end
    endfunction


endclass

endpackage