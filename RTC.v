`include "fr_divider.v"
`include "real_time.v"
`include "calendar.v"
`include "alarm.v"

module RTC(
    input wire set_time,
    input wire set_cal,
    input wire clk,
    input wire [23:0]set_full_time,// format hour[23:16] - min[15:8] - sec[7:0]
    input wire [35:0]set_full_cal,//format day[35:28] - weekday[27:24] - month[23:16] - year[15:0]
    input wire [27:0]set_alarm_time,//format hour[27:20] - min[19:12] - day[11:4] -weekday[3:0]
    input wire intr_alarm,
    output wire [23:0] full_time,// format hour[23:16] - min[15:8] - sec[7:0]
    output wire [35:0] full_cal,//format day[35:28] - weekday[27:24] - month[23:16] - year[15:0]
    output wire alarm_flag
);
wire clk_w;
wire[7:0] real_w_cc;
wire[7:0] real_w_min;
wire[7:0] real_w_day;
wire[3:0] real_w_weekday;



fr_divider uut1(.clk(clk),.d_clk(clk_w));
      // clk_w goes from frequency divider to real_time clock
real_time uut2 (
       .d_clk(clk_w),
       .set(set_time),
       .set_min(set_full_time[15:8]),
       .set_hour(set_full_time[23:16]),
       .set_sec(set_full_time[7:0]),
       .real_min(real_w_min),
       .real_hour(real_w_cc),
       .full_time(full_time)
   );// real_w_cc takes real hours from clock and feed to calender
calendar uut3(
        .set_cal(set_cal),
        .set_day(set_full_cal[35:28]),
        .set_weekday(set_full_cal[27:24]),
        .set_month(set_full_cal[23:16]),
        .set_year(set_full_cal[15:0]),
        .real_hour(real_w_cc),
        .real_day(real_w_day),
        .real_weekday(real_w_weekday),
        .full_cal(full_cal)
    );
 
alarm uut4(
    .min_alarm(set_alarm_time[19:12]),
    .hour_alarm(set_alarm_time[27:20]),
    .day_alarm(set_alarm_time[11:4]),
    .weekday_alarm(set_alarm_time[3:0]),
    .real_min(real_w_min),
    .real_hour(real_w_cc),
    .real_day(real_w_day),
    .real_weekday(real_w_weekday),
    .intr(intr_alarm),
    .clk(clk_w),
    .alarm_flag(alarm_flag)
);

endmodule
