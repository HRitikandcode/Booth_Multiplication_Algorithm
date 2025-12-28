`timescale 1ns/1ps

module tb_booth_multiplier;

    parameter N = 8;

    reg  signed [N-1:0] multiplicand;
    reg  signed [N-1:0] multiplier;
    reg                 clk;
    reg                 rst;
    reg                 start;

    wire signed [2*N-1:0] product;
    wire                done;

    // Instantiate the Booth Multiplier
    booth_algo #(
        .N(N)
    ) dut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .clk(clk),
        .rst(rst),
        .start(start),
        .product(product),
        .done(done)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        start = 0;
        multiplicand = 0;
        multiplier   = 0;

        // Apply reset
        #20;
        rst = 0;

        // ---- Test Case 1 ----
        @(negedge clk);
        multiplicand =  8'sd5;
        multiplier   =  8'sd3;
        start = 1;

        @(negedge clk);
        start = 0;

        wait(done);
        $display("TEST1: %0d x %0d = %0d",
                  multiplicand, multiplier, product);

        // ---- Test Case 2 ----
        @(negedge clk);
        multiplicand = -8'sd5;
        multiplier   =  8'sd3;
        start = 1;

        @(negedge clk);
        start = 0;

        wait(done);
        $display("TEST2: %0d x %0d = %0d",
                  multiplicand, multiplier, product);

        // ---- Test Case 3 ----
        @(negedge clk);
        multiplicand = -8'sd7;
        multiplier   = -8'sd6;
        start = 1;

        @(negedge clk);
        start = 0;

        wait(done);
        $display("TEST3: %0d x %0d = %0d",
                  multiplicand, multiplier, product);

        // ---- Test Case 4 ----
        @(negedge clk);
        multiplicand =  8'sd0;
        multiplier   = -8'sd25;
        start = 1;

        @(negedge clk);
        start = 0;

        wait(done);
        $display("TEST4: %0d x %0d = %0d",
                  multiplicand, multiplier, product);

        // Finish simulation
        #20;
        $finish;
    end

endmodule
