module fifo_chipverify #(
    parameter int DEPTH  = 8,
    parameter int WIDTH = 8
)(
    input  logic               rstn,    // Active low reset
                                clk,     // Clock
                                push,   // push
                                pop,   // pop
    input  logic [WIDTH-1:0]  write,      // Data written into FIFO
    output logic [WIDTH-1:0]  read,     // Data read from FIFO
    output logic               empty,    // FIFO empty flag
                                full      // FIFO full flag
);

    // Pointer widths
    logic [$clog2(DEPTH)-1:0] wptr;
    logic [$clog2(DEPTH)-1:0] rptr;

    // FIFO memory
    logic [WIDTH-1:0][DEPTH-1:0]fifo ;

    // Write logic
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            wptr <= '0;
            for (int i=0; i<DEPTH; i++) begin
                fifo[i] <= '0;
            end
        end
        else if (push && !full) begin
            fifo[wptr] <= write;
            wptr <= wptr + 1;
        end
    end

    // Read logic
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            rptr <= '0;
        end
        else if (pop && !empty) begin
            rptr <= rptr + 1;
        end
    end

    // Status flags
    assign read = fifo[rptr];
    assign full  = ((wptr + 1) == DEPTH);
    assign empty = (wptr == rptr);

endmodule