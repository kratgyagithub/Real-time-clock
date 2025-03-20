module fr_divider(input wire clk,output reg d_clk);

integer count = 0;

always @(posedge clk)begin
  count = count +1;
  if(count < 16932)begin
    d_clk = 0;
  end
  if(count > 16932 && count <34316)begin
    d_clk = 1;
  end
  if (count >34316) count = 0;
end
endmodule
