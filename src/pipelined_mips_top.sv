module pipelined_mips_top ();
    
    bit clk, start_program;
    always begin
        #5 if (start_program) clk = ~clk;
    end
    
    bit [31:0] instruction_memory [0:1023];
    bit [31:0] data_memory [0:1023];

    assign DUT.instruction_memory = instruction_memory;
    assign data_memory = DUT.data_memory;

    pipelined_mips_if _if(clk);
    
    pipelined_mips DUT(_if);
    pipelined_mips_tb TEST(_if, data_memory, instruction_memory, start_program);
    pipelined_mips_monitor MONITOR(_if, data_memory);
    
    bind DUT pipelined_mips_sva SVA(_if);

endmodule
