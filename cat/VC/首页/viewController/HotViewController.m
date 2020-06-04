//
//  HotViewController.m
//  cat
//
//  Created by 王成龙 on 2019/8/29.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "HotViewController.h"
#import <FSCalendar.h>

@interface HotViewController ()<FSCalendarDelegate,FSCalendarDataSource>

@property (nonatomic ,strong) UIView *calculView;
@property (nonatomic ,strong) FSCalendar * calendar;
@property (strong, nonatomic) NSCalendar *gregorianCalendar;
@property (nonatomic ,strong) NSArray * datesWithEvent;


@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.calculView];
    self.datesWithEvent = @[@"2019-11-21",@"2019-11-12",@"2019-11-25"];
    
    _calendar = [[FSCalendar alloc]initWithFrame:CGRectMake(0, 0, lSCREEN_WIDTH, 246)];
//    _calendar.backgroundColor = [UIColor orangeColor];
    _calendar.delegate = self;
    _calendar.dataSource = self;
    //设置星期的颜色
    _calendar.appearance.weekdayTextColor = [UIColor redColor];
    //表头的颜色
    _calendar.appearance.headerTitleColor = [UIColor yellowColor];
    
    _calendar.appearance.borderRadius = 20;
    //今天的颜色
    _calendar.appearance.todayColor = [UIColor blueColor];
        _calendar.headerHeight = 0.0f; // 当不显示头的时候设置

    //隐藏上下月的透明度
    _calendar.appearance.headerMinimumDissolvedAlpha = 0;
    
    [_calendar selectDate:[NSDate date]]; // 设置默认选中日期是今天
    [_calendar setToday:[NSDate date]];
    
    _calendar.appearance.headerDateFormat = @"yyyy年MM月";
    _calendar.scope = FSCalendarScopeMonth;
   
    [self.calculView addSubview:self.calendar];
  
    self.gregorianCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];

}
- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorianCalendar isDateInToday:date]) {
        return @"今天";
    }
    return nil;
}
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      dateFormatter.dateFormat = @"yyyy-MM-dd";
      if ([self.datesWithEvent containsObject:[dateFormatter stringFromDate:date]]) {
          return 1;
      }
      return 0;
  
}


- (UIView *)calculView{
    if(!_calculView){
        _calculView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, lSCREEN_WIDTH, 246)];
        _calculView.backgroundColor = lRGBACOLOR(245,245,245, 1);
    }
    return _calculView;
}


@end
