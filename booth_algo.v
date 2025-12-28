module booth_algo #(parameter N = 8)
(
    input clk,
    input rst,
    input start,
    input signed [N-1:0] multiplier,
    input signed [N-1:0] multiplicand,
    output reg signed [2*N-1:0] product,
    output reg done
);

    reg signed [N-1:0] A;   // Accumulator
    reg signed [N-1:0] Q;   // Multiplier
    reg signed [N-1:0] M;   // Multiplicand
    reg               Q_1;  // Extra bit
    reg [$clog2(N):0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A <= 0;
            Q <= 0;
            M <= 0;
            Q_1 <= 0;
            count <= 0;
            product <= 0;
            done <= 0;
        end
        else if (start && count == 0) begin
            A <= 0;
            Q <= multiplier;
            M <= multiplicand;
            Q_1 <= 0;
            count <= N;
            done <= 0;
        end
        else if (count > 0) begin
            // Booth decision
            case ({Q[0], Q_1})
                2'b01: A = A + M;
                2'b10: A = A - M;
                default: A = A;
            endcase

            // Shift AFTER operation (uses updated A)
            Q_1 <= Q[0];
            Q   <= {A[0], Q[N-1:1]};
            A   <= {A[N-1], A[N-1:1]};

            count <= count - 1;
        end
        else begin
            product <= {A, Q};
            done <= 1;
        end
    end

endmodule
