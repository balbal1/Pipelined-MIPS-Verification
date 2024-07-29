interface pipelined_mips_if(input clk);
    
    bit rst;

    modport DUT (
        input clk, rst
    );
    
    modport TEST (
        input clk,
        output rst
    );
    
    modport MONITOR (
        input clk, rst
    );
    
endinterface
