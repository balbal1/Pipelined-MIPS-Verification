package min_max_test_pkg;

class min_max_test;
    
    rand bit [15:0] values[8];
    bit [15:0] max[$], min[$], sum;


    function void post_randomize();

        this.max = this.values.max();
        this.min = this.values.min();
        this.sum = this.values.sum();

    endfunction

endclass


endpackage