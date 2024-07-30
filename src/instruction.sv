import enums_pkg::*;

package instruction_pkg;

class Instruction;

    rand enums_pkg::types instruction_type;
    
    rand enums_pkg::R_instructions funct;
    rand enums_pkg::I_instructions i_op_code;
    rand enums_pkg::J_instructions j_op_code;
    rand enums_pkg::Registers rs, rt, rd;
    
    rand bit [4:0] shmat;
    rand bit [15:0] immediate;
    rand bit [25:0] address;
    
    bit clk;
    bit [31:0] instruction_word;
    enums_pkg::All_formats command;

    function void generate_word ();
        if (this.instruction_type == enums_pkg::R_format) begin
            this.instruction_word = {6'd0, rs, rt, rd, shmat, funct};
            this.command = enums_pkg::All_formats'({1'b0, funct});
        end else if (instruction_type == enums_pkg::I_format) begin
            this.instruction_word = {i_op_code, rs, rt, immediate};
            this.command = enums_pkg::All_formats'({1'b1, i_op_code});
        end else if (instruction_type == enums_pkg::J_format) begin
            this.instruction_word = {j_op_code, address};
            this.command = enums_pkg::All_formats'({1'b1, j_op_code});
        end
    endfunction

    function void set_r_command (
        enums_pkg::R_instructions funct,
        enums_pkg::Registers rs, rt, rd
    );
        this.instruction_type = enums_pkg::R_format;
        this.funct = funct;
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
        this.shmat = 0;
        this.generate_word();
    endfunction

    function void set_shift_command (
        enums_pkg::R_instructions funct,
        enums_pkg::Registers rs, rt, rd,
        bit [4:0] shmat
    );
        this.instruction_type = enums_pkg::R_format;
        this.funct = funct;
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
        this.shmat = shmat;
        this.generate_word();
    endfunction

    function void set_half_i_command (
        enums_pkg::I_instructions i_op_code,
        enums_pkg::Registers rs, rt
    );
        this.instruction_type = enums_pkg::I_format;
        this.i_op_code = i_op_code;
        this.rs = rs;
        this.rt = rt;
        this.generate_word();
    endfunction

    function void set_full_i_command (
        enums_pkg::I_instructions i_op_code,
        enums_pkg::Registers rs, rt,
        bit [15:0] immediate
    );
        this.instruction_type = enums_pkg::I_format;
        this.i_op_code = i_op_code;
        this.rs = rs;
        this.rt = rt;
        this.immediate = immediate;
        this.generate_word();
    endfunction

    covergroup instruction_coverage @(posedge clk);
        
        coverpoint instruction_type;

        coverpoint command {
            bins logic_commands = {
                enums_pkg::And,
                enums_pkg::andi,
                enums_pkg::Or,
                enums_pkg::ori,
                enums_pkg::Nor,
                enums_pkg::Xor,
                enums_pkg::xori
            };

            bins arithmatic_commands = {
                enums_pkg::add,
                enums_pkg::addi,
                enums_pkg::addu,
                enums_pkg::addiu,
                enums_pkg::sub,
                enums_pkg::divu,
                enums_pkg::lui
            };

            bins shift_commands = {
                enums_pkg::sll,
                enums_pkg::sllv,
                enums_pkg::sra,
                enums_pkg::srav,
                enums_pkg::srl,
                enums_pkg::srlv
            };

            bins jump_commands = {
                enums_pkg::j,
                enums_pkg::jal,
                enums_pkg::jr,
                enums_pkg::jalr
            };

            bins branch_commands = {
                enums_pkg::beq,
                enums_pkg::bne,
                enums_pkg::bgez
            };

            bins store_commands = {
                enums_pkg::sw,
                enums_pkg::sh,
                enums_pkg::sb
            };

            bins load_commands = {
                enums_pkg::lw,
                enums_pkg::lh,
                enums_pkg::lhu,
                enums_pkg::lb,
                enums_pkg::lbu
            };

            bins set_less_than_commands = {
                enums_pkg::slt,
                enums_pkg::sltu,
                enums_pkg::sltiu,
                enums_pkg::slti
            };
        }

    endgroup

    covergroup register_coverage @(posedge clk);

        coverpoint rs {
            bins temp_regs = {
                enums_pkg::t0,
                enums_pkg::t1,
                enums_pkg::t2,
                enums_pkg::t3,
                enums_pkg::t4,
                enums_pkg::t5,
                enums_pkg::t6,
                enums_pkg::t7,
                enums_pkg::t8,
                enums_pkg::t9
            };

            bins stored_regs = {
                enums_pkg::s0,
                enums_pkg::s1,
                enums_pkg::s2,
                enums_pkg::s3,
                enums_pkg::s4,
                enums_pkg::s5,
                enums_pkg::s6,
                enums_pkg::s7
            };

            bins v_regs = {
                enums_pkg::v0,
                enums_pkg::v1
            };

            bins a_regs = {
                enums_pkg::a0,
                enums_pkg::a1,
                enums_pkg::a2,
                enums_pkg::a3
            };

            ignore_bins special_regs = {
                enums_pkg::gp,
                enums_pkg::fp,
                enums_pkg::sp,
                enums_pkg::ra
            };
        }

    endgroup


    function new();
        instruction_coverage = new();
        register_coverage = new();
    endfunction

endclass

endpackage