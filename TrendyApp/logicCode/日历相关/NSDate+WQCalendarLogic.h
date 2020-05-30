

#import <Foundation/Foundation.h>

@interface NSDate (WQCalendarLogic)

- (NSUInteger)numberOfDaysInCurrentMonth;

- (NSUInteger)numberOfWeeksInCurrentMonth;

- (NSUInteger)weeklyOrdinality;

- (NSDate *)firstDayOfCurrentMonth;

- (NSDate *)lastDayOfCurrentMonth;

- (NSDate *)dayInThePreviousMonth;

- (NSDate *)dayInTheFollowingMonth;

- (NSDate *)dayInTheFollowingMonth:(int)month;//获取当前日期之后的几个月

- (NSDate *)dayInTheFollowingDay:(int)day;//获取当前日期之后的几个天
//获取当前日期之前的几个天
- (NSDate *)dayBeforeTheFollowingDay:(int)day;

- (NSDateComponents *)YMDComponents;

- (NSDate *)dateFromString:(NSString *)dateString;//NSString转NSDate

- (NSString *)stringFromDatetemplate;//NSDate转NSString

+ (int)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;

-(int)getWeekIntValueWithDate;

/*
 @{@"weekNum":[NSString stringWithFormat:@"%ld",weekIntValue],
 @"strStart":[formater stringFromDate:firstDayOfWeek],
 @"strEnd":[formater stringFromDate:lastDayOfWeek],
 @"timeStart":[NSString stringWithFormat:@"%f",[firstDayOfWeek timeIntervalSince1970]],
 @"timeEnd":[NSString stringWithFormat:@"%f",[lastDayOfWeek timeIntervalSince1970]]};
 */
///返回当前是本年的第几周（开始时间、结束时间）
-(NSDictionary *)getWhatTheCurrentWeek;


//判断日期是今天,明天,后天,周几
-(NSString *)compareIfTodayWithDate;
//通过数字返回星期几
+(NSString *)getWeekStringFromInteger:(int)week;

@end
