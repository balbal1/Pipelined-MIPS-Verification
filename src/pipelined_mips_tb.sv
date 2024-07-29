import instruction_pkg::*;

module pipelined_mips_tb(pipelined_mips_if.TEST _if, output bit [31:0] instruction_memory [0:1023]);
    
    typedef enum bit [1:0] {R_type = 1, I_type, J_type} types;
    Instruction instruction = new();

    initial begin
        
        _if.rst = 0;
        #10;
        _if.rst = 1;
        #10;
        _if.rst = 0;

        for (int i = 0; i < 10; i = i + 1) begin
            assert(instruction.randomize);
            instruction.generate_type();
            instruction.generate_word();
            instruction_memory[i] = instruction.instruction_word; 
        end

        #200;

        $stop;
    end
    
endmodule
