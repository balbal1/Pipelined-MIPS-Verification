module pipelined_mips_monitor (pipelined_mips_if.MONITOR _if, input bit [31:0] data_memory [0:1023]);
    
    initial begin
        $monitor("");
    end
    
endmodule
