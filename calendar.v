module calendar(
    // input wire d_clk,
    input wire set_cal,
    input wire [7:0] set_day,
    input wire [3:0] set_weekday,
    input wire [7:0] set_month,
    input wire [15:0] set_year,
    input wire [7:0] real_hour,
    output reg [7:0] real_day = 1,
    output reg [3:0] real_weekday =1,
    output reg [7:0] real_month = 1,
    output reg [15:0] real_year= 1,
    output reg [35:0] full_cal
    );
    
    reg set_cal_check;

    always@(real_hour) begin
        set_cal_check <= set_cal;
        full_cal <= {real_day,real_weekday,real_month,real_year};

        if (set_cal_check == 1)begin
            real_day = set_day;
            real_weekday = set_weekday;
            real_month = set_month;
            real_year = set_year;
            set_cal_check = 0;
        end
        if (real_hour[7:4] == 2 && real_hour[3:0]  == 3)begin
          real_day = real_day + 1;
          real_weekday = real_weekday + 1;
        end
        if ( real_day[3:0] == 10)begin
          real_day[7:4] = real_day[7:4] +  1;
          real_day[3:0] = 1;
        end
        if ( real_month[3:0] == 10)begin
          real_month[7:4] = real_month[7:4] +  1;
          real_month[3:0] = 0;
        end
        if (real_month[3:0] == 1 || real_month[3:0] == 3 || real_month[3:0] == 5 || real_month[3:0] == 7 || real_month[3:0] == 8|| real_month == 8'h10 || real_month == 8'h12)begin
          if(real_day[7:4] == 3 && real_day[3:0] == 2)begin// 31 days 
            real_month = real_month + 1;
            real_day = 1;
          end
        end
        if (real_month[3:0] == 4 || real_month[3:0] == 6 || real_month[3:0] == 9 || (real_month[7:4] == 1 && real_month[3:0] == 1))begin
          if(real_day[7:4] == 3 && real_day[3:0] == 1)begin// 30 days 
            real_month = real_month + 1;
            real_day = 1;
          end
        end
        if (real_month[3:0] == 2)begin
          if(real_day[7:4] == 2 && real_day[3:0] == 9)begin
            real_month = real_month + 1;
            real_day = 1;
          end
        end

        if (real_month[7:4] == 1 && real_month[3:0]== 3)begin// add year overflow logic
          real_year = real_year +1;
          real_month = 1;
        end
        if (real_year == 16'b1111111111111111)begin
          real_day = 1;
          real_month = 1;
          real_year = 1;
          real_weekday = 1;
        end
        if (real_weekday == 8 )begin
          real_weekday = 1;
        end
    end

endmodule
