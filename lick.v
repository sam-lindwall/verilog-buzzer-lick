module lick(
    input mclk,
    input switch,
    output reg speaker
);

    // Function to calculate the number of internal clock pulses for a given frequency
    function integer cycles(input [15:0] frequency);
        begin
            cycles = 50000000 / (2 * frequency);
        end
    endfunction

    reg [25:0] counter = 0;       // Dictates how long each note is played
    reg [3:0] note = 0;           // Used in case statement for each note
    reg [31:0] num_cycles;        // Internal clock signals for each note's frequency
    reg [31:0] q;                 // Controls frequency of buzzer oscillation

    always @(posedge mclk) begin
        if (switch) begin
            counter <= counter + 1;
            if (counter == 10000000) begin    // Adjust for desired note duration
                counter <= 0;
                if (note == 9)
                    note <= 0;                // Wrap around to replay melody
                else
                    note <= note + 1;         // Move to next note
            end
        end else begin
            counter <= 0;                     // Reset when switch is off
            note <= 0;
        end
    end

    // Case statement: each note corresponds to a specific frequency
    always @(*) begin
        case (note)
            0: num_cycles = cycles(294);  // D
            1: num_cycles = cycles(323);  // E
            2: num_cycles = cycles(349);  // F
            3: num_cycles = cycles(392);  // G
            4: num_cycles = cycles(323);  // E
            5: num_cycles = cycles(323);  // E
            6: num_cycles = cycles(262);  // C
            7: num_cycles = cycles(294);  // D
            8: num_cycles = 0;            // Pause
            9: num_cycles = 0;            // Pause
            default: num_cycles = 0;
        endcase
    end

    // Generate sound by oscillating buzzer at the given frequency
    always @(posedge mclk) begin
        if (switch) begin
            if (q < num_cycles)
                q <= q + 1;
            else begin
                speaker <= ~speaker;  // Toggle speaker output
                q <= 0;               // Restart counter for square wave generation
            end
        end else begin
            q <= 0;
            speaker <= 0;
        end
    end
endmodule
