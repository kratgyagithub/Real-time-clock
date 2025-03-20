module real_time(
    input wire d_clk,
    input wire set,
    input wire [7:0]set_min,
    input wire [7:0]set_hour,
    input wire [7:0]set_sec ,
    output reg [7:0]real_min = 0,
    output reg [7:0]real_hour = 0,
    output reg [7:0]real_sec = 0,
    output reg [23:0]full_time
);

reg set_check;


always@(posedge d_clk)begin
    full_time = {real_hour,real_min,real_sec};
    if (set == 1) set_check = 1;
    if (set == 1)begin
      real_sec = set_sec;
      real_min = set_min;
      real_hour = set_hour;
      set_check = 0;
    end
    real_sec[3:0] = real_sec[3:0] + 1;
    if(real_sec[6:4]<5 && real_sec[3:0]>9)begin
      real_sec[6:4] <= real_sec[6:4]+1;
      real_sec[3:0] <= 0;
    end
    if(real_sec[6:4] == 5 && real_sec[3:0] == 10)begin
      real_min[3:0] <= real_min[3:0] + 1;
      real_sec[6:0] <= 0;
    end
    if(real_min[6:4] == 5 && real_min[3:0] == 9)begin
      real_hour[3:0] <= real_hour[3:0]+1;
      real_min <= 0;

    end
    if(real_hour[6:4] == 2 && real_hour[3:0] == 4)begin
      real_hour <= 0;
      real_min <= 0;
      real_sec <=0;
    end
end
endmodule
