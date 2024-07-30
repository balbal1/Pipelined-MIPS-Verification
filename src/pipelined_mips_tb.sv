import instruction_pkg::*;
import min_max_test_pkg::*;

module pipelined_mips_tb(pipelined_mips_if.TEST _if, input bit [31:0] data_memory [0:1023], output bit [31:0] instruction_memory [0:1023], output bit start_program);
    
    Instruction instruction = new();
    min_max_test min_max_test_1 = new();

    bit clk;

    always begin
      #20 clk = ~clk;
	  instruction.clk = clk;
  	end

    initial begin
        
        start_program = 0;
        _if.rst = 0;
        #10;
        _if.rst = 1;
        #10;
        _if.rst = 0;

        // instruction.instruction_coverage.start();
        instruction.set_full_i_command(enums_pkg::_addi, enums_pkg::zero, enums_pkg::t2, 0);
        instruction_memory[0] = instruction.instruction_word;
        // instruction.instruction_coverage.stop();
        // instruction.instruction_coverage.sample();
        #20;
        
        instruction.set_full_i_command(enums_pkg::_addi, enums_pkg::zero, enums_pkg::t3, -1);
        instruction_memory[1] = instruction.instruction_word;
        #20;

        instruction.set_full_i_command(enums_pkg::_addi, enums_pkg::zero, enums_pkg::s0, 0);
        instruction_memory[2] = instruction.instruction_word;
        #20;

        assert(min_max_test_1.randomize);

        for (int i = 0; i < 16; i = i + 2) begin
            instruction.set_full_i_command(enums_pkg::_addi, enums_pkg::t1, enums_pkg::zero, min_max_test_1.values[i/2]);
            instruction_memory[i+3] = instruction.instruction_word;
            #20;
            
            instruction.set_full_i_command(enums_pkg::_sw, enums_pkg::zero, enums_pkg::t1, i*2);
            instruction_memory[i+4] = instruction.instruction_word;
            #20;
        end

        instruction.set_full_i_command(enums_pkg::_addi, enums_pkg::zero, enums_pkg::t1, 1);
        instruction_memory[19] = instruction.instruction_word;
        #20;

        instruction.set_full_i_command(enums_pkg::_addi, enums_pkg::zero, enums_pkg::t6, 6);
        instruction_memory[20] = instruction.instruction_word;
        #20;

        instruction.set_full_i_command(enums_pkg::_addi, enums_pkg::t0, enums_pkg::t0, 4);
        instruction_memory[21] = instruction.instruction_word;
        #20;

        instruction.set_full_i_command(enums_pkg::_lw, enums_pkg::t0, enums_pkg::t5, 0);
        instruction_memory[22] = instruction.instruction_word;
        #20;

        instruction.set_r_command(enums_pkg::_add, enums_pkg::s0, enums_pkg::t5, enums_pkg::s0);
        instruction_memory[23] = instruction.instruction_word;
        #20;

        instruction.set_r_command(enums_pkg::_slt, enums_pkg::t2, enums_pkg::t5, enums_pkg::t8);
        instruction_memory[24] = instruction.instruction_word;
        #20;

        instruction.set_r_command(enums_pkg::_slt, enums_pkg::t5, enums_pkg::t3, enums_pkg::t9);
        instruction_memory[25] = instruction.instruction_word;
        #20;

        instruction.set_full_i_command(enums_pkg::_addi, enums_pkg::t1, enums_pkg::t1, 1);
        instruction_memory[26] = instruction.instruction_word;
        #20;

        instruction.set_full_i_command(enums_pkg::_beq, enums_pkg::t8, enums_pkg::zero, 4);
        instruction_memory[27] = instruction.instruction_word;
        #20;

        instruction.set_r_command(enums_pkg::_add, enums_pkg::zero, enums_pkg::t5, enums_pkg::t2);
        instruction_memory[28] = instruction.instruction_word;
        #20;

        instruction.set_full_i_command(enums_pkg::_beq, enums_pkg::t9, enums_pkg::zero, 4);
        instruction_memory[29] = instruction.instruction_word;
        #20;

        instruction.set_r_command(enums_pkg::_add, enums_pkg::zero, enums_pkg::t5, enums_pkg::t3);
        instruction_memory[30] = instruction.instruction_word;
        #20;

        instruction.set_full_i_command(enums_pkg::_bne, enums_pkg::t1, enums_pkg::t6, -44);
        instruction_memory[31] = instruction.instruction_word;
        #20;

        instruction.set_full_i_command(enums_pkg::_sw, enums_pkg::zero, enums_pkg::t2, 0);
        instruction_memory[32] = instruction.instruction_word;
        #20;

        instruction.set_full_i_command(enums_pkg::_sw, enums_pkg::zero, enums_pkg::t3, 4);
        instruction_memory[33] = instruction.instruction_word;
        #20;
        
        instruction.set_full_i_command(enums_pkg::_sw, enums_pkg::zero, enums_pkg::s0, 8);
        instruction_memory[34] = instruction.instruction_word;
        #20;

        start_program = 1;

        #200;

        for (int i = 0; i < 8; i = i + 1) begin        
            $display("value %0d = %0d", i, min_max_test_1.values[i]);
        end
        if(data_memory[0] != min_max_test_1.min[0]) $display("Error in min value, expected = %0d, result %0d", min_max_test_1.min[0], data_memory[0]);
        if(data_memory[1] != min_max_test_1.max[0]) $display("Error in max value, expected = %0d, result %0d", min_max_test_1.max[0], data_memory[1]);
        if(data_memory[2] != min_max_test_1.sum) $display("Error in sum value, expected = %0d, result %0d", min_max_test_1.sum, data_memory[2]);

        $stop;
    end
    
endmodule
