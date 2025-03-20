module alarm(
    input wire [7:0]min_alarm,
    input wire [7:0]hour_alarm,
    input wire [7:0]day_alarm,
    input wire [3:0]weekday_alarm,
    input wire [7:0]real_min,
    input wire [7:0]real_hour,
    input wire [7:0]real_day,
    input wire [3:0]real_weekday,
    input wire intr,
    input wire clk,
    output reg alarm_flag = 1'b0
);

wire check_flag;

assign check_flag = alarm_flag;

always@(posedge clk)begin
  // only min
  if (min_alarm[7] && ~hour_alarm[7] && ~weekday_alarm[7] && ~ day_alarm[7])begin
    if(min_alarm[6:0] == real_min[6:0])begin
       alarm_flag <= 1'b1;     
    end
  end
   // only hour and minute
  if (min_alarm[7] && hour_alarm[7] && weekday_alarm[7] && ~ day_alarm[7])begin
    if(hour_alarm[5:0] == real_hour[5:0] && min_alarm[6:0] == real_min[6:0])begin
       alarm_flag <= 1'b1;     
    end
  end
  // with weekday
  if (min_alarm[7] && hour_alarm[7] && weekday_alarm[7] && ~ day_alarm[7])begin
    if(hour_alarm[5:0] == real_hour[5:0] && min_alarm[6:0] == real_min[6:0] && weekday_alarm[2:0] == real_weekday[2:0])begin
       alarm_flag <= 1'b1;     
    end
  end
  //with day(date)
  if (min_alarm[7] && hour_alarm[7] && ~weekday_alarm[7] && day_alarm[7])begin
    if(hour_alarm[5:0] == real_hour[5:0] && min_alarm[6:0] == real_min[6:0] && day_alarm[5:0] == real_day[5:0])begin
       alarm_flag <= 1'b1;     
    end
  end
  //with both day and weekday
  if (min_alarm[7] && hour_alarm[7] && weekday_alarm[7] && day_alarm[7])begin
    if((hour_alarm[5:0] == real_hour[5:0] && min_alarm[6:0] == real_min[6:0] && day_alarm[5:0] == real_day[5:0])||(hour_alarm[5:0] == real_hour[5:0] && min_alarm[6:0] == real_min[6:0] && weekday_alarm[2:0] == real_weekday[2:0]))begin
       alarm_flag <= 1'b1;     
    end
  end
  // intrupt (or turn off the alarm)
  if(check_flag)begin
    if(intr)begin
      alarm_flag <= 1'b0;
    end
  end
end
endmodule

