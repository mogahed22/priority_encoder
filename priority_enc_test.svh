module priority_enc_test;

logic clk,rst;
logic [3:0]D;
logic [1:0]Y;
logic valid;

integer error_count , correct_count;

priority_enc test(.*);

initial begin
    clk = 0;
    forever begin
        #1 clk = ~clk;
    end
    
end

initial begin
    error_count = 0;
    correct_count = 0;
    checkreset;
    D=4'b0000;
    checkzerovalid(0);
    D=4'b1000;
    checkresult(2'b00,1'b1);
    D=4'bx100;
    checkresult(2'b01,1'b1);
    D=4'bxx10;
    checkresult(2'b10,1'b1);
    D=4'bxxx1;
    checkresult(2'b11,1'b1);
    $stop;
end

task checkreset;
    rst = 1;
    @(negedge clk);
    if(Y !== 0 && valid !==0) begin
        $display("\t Error",$time);
        error_count = error_count + 1;
    end
    else correct_count = correct_count +1;
    rst = 0;
endtask

task checkzerovalid;
    input expected_valid;
    @(negedge clk);
    if(valid !== expected_valid)begin
        $display("\t error",$time);
        error_count = error_count +1;
    end
    else correct_count = correct_count + 1;
endtask

task checkresult;
    input [1:0] expected_Y;
    input expected_valid;
    @(negedge clk );
    if(Y !== expected_Y || valid !== expected_valid)begin
        $display("\t error",$time);
        error_count = error_count +1;
    end
    else correct_count = correct_count + 1;
endtask

endmodule