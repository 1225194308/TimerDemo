//
//  ViewController.m
//  Timer
//
//  Created by shao on 16/3/30.
//  Copyright © 2016年 曹少帅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString *_setTimeString;
    NSArray *_timeArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bottomView.layer.cornerRadius = self.bottomView.frame.size.width * 0.5;
    self.bottomView.clipsToBounds = YES;
    
    // 设置时间点
    _setTimeString = @"2:00:00";
    
    _timeArray = [_setTimeString componentsSeparatedByString:@":"];
    
    
    [self refreshTime];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
}
- (void)refreshTime
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond |NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitQuarter |NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear fromDate:[NSDate date]];
    
    NSCalendar *todayCalender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *todayDateComponents = [[NSDateComponents alloc] init];
    todayDateComponents.year = dateComponents.year;
    todayDateComponents.month = dateComponents.month;
    todayDateComponents.day = dateComponents.day;
    todayDateComponents.hour = [_timeArray[0] integerValue];
    todayDateComponents.minute = [_timeArray[1] integerValue];
    todayDateComponents.second = [_timeArray[2] integerValue];
    
    
    NSDate *todayDate = [todayCalender dateFromComponents:todayDateComponents];
    
    NSDateComponents *betweenDate = [todayCalender components:NSCalendarUnitSecond fromDate:[NSDate date] toDate:todayDate options:0];
    
    NSString *betweenTime;
    // 已经过时
    if (betweenDate.second < 0)
    {
        betweenTime = [self hourMinuteSecond:-betweenDate.second];
        self.titleLabel.text = [NSString stringWithFormat:@"距离放学\n%@\n已经过时",_setTimeString];
    }
    // 距离xxx点还有多久
    else
    {
        betweenTime = [self hourMinuteSecond:betweenDate.second];
        self.titleLabel.text = [NSString stringWithFormat:@"距离放学\n%@\n还有",_setTimeString];
    }
    
    self.showTimeLabel.text = betweenTime;
}


- (NSString *)hourMinuteSecond:(NSInteger)time
{
    NSString *timeString;
    
    // 秒
    timeString = [NSString stringWithFormat:@"%ld秒",time%60];
    
    // 分
    time /= 60;
    if (time >0)
    {
        timeString = [NSString stringWithFormat:@"%ld分\n%@",time%60,timeString];
    }
    
    // 时
    time /= 60;
    if (time > 0)
    {
        timeString = [NSString stringWithFormat:@"%ld小时\n%@",time%60,timeString];
    }
    
    return timeString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
