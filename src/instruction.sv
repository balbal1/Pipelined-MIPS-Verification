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

endclass

endpackage