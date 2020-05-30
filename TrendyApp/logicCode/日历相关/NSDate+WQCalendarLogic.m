

#import "NSDate+WQCalendarLogic.h"

@implementation NSDate (WQCalendarLogic)


/*计算这个月有多少天*/
- (NSUInteger)numberOfDaysInCurrentMonth
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}


//获取这个月有多少周
- (NSUInteger)numberOfWeeksInCurrentMonth
{
    NSUInteger weekday = [[self firstDayOfCurrentMonth] weeklyOrdinality];
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}



/*计算这个月的第一天是礼拜几*/
- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];
}



//计算这个月最开始的一天
- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}


- (NSDate *)lastDayOfCurrentMonth
{
    NSCalendarUnit calendarUnit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self];
    dateComponents.day = [self numberOfDaysInCurrentMonth];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

///上一个月
- (NSDate *)dayInThePreviousMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

///下一个月
- (NSDate *)dayInTheFollowingMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}


///获取当前日期之后的几个月
- (NSDate *)dayInTheFollowingMonth:(int)month
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = month;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

///获取当前日期之前的几个月
- (NSDate *)dayInThePreviousMonth:(int)month
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -month;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}


///获取当前日期之后的几个天
- (NSDate *)dayInTheFollowingDay:(int)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = day;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

/////获取当前日期之前的几个天
//- (NSDate *)dayBeforeTheFollowingDay:(int)day
//{
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//    dateComponents.day = -day;
//    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
//}

//获取年月日对象
- (NSDateComponents *)YMDComponents
{
    return [[NSCalendar currentCalendar] components:
            NSYearCalendarUnit|
            NSMonthCalendarUnit|
            NSDayCalendarUnit|
            NSWeekdayCalendarUnit fromDate:self];
}


//-----------------------------------------
//
//NSString转NSDate
- (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
//    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}



//NSDate转NSString
- (NSString *)stringFromDatetemplate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:self];
    
    return destDateString;
}


+ (int)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//日历控件对象
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:today toDate:beforday options:0];
    //    NSDateComponents *components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today toDate:beforday options:0];
    NSInteger day = [components day];//两个日历之间相差多少月//    NSInteger days = [components day];//两个之间相差几天
    return day;
}


//周日是“1”，周一是“2”...
-(int)getWeekIntValueWithDate
{
    int weekIntValue;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *comps= [calendar components:(NSYearCalendarUnit |
                                                   NSMonthCalendarUnit |
                                                   NSDayCalendarUnit |
                                                   NSWeekdayCalendarUnit) fromDate:self];
    return weekIntValue = [comps weekday];
}

/*
 @{@"weekNum":[NSString stringWithFormat:@"%ld",weekIntValue],
 @"strStart":[formater stringFromDate:firstDayOfWeek],
 @"strEnd":[formater stringFromDate:lastDayOfWeek],
 @"timeStart":[NSString stringWithFormat:@"%f",[firstDayOfWeek timeIntervalSince1970]],
 @"timeEnd":[NSString stringWithFormat:@"%f",[lastDayOfWeek timeIntervalSince1970]]};
 */
///返回当前是本年的第几周（开始时间、结束时间）
-(NSDictionary *)getWhatTheCurrentWeek
{
    NSMutableDictionary *dicT=[NSMutableDictionary new];
    NSInteger weekIntValue;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
//    NSDateComponents *comps= [calendar components:(NSYearCalendarUnit |
//                                                   NSMonthCalendarUnit |
//                                                   NSDayCalendarUnit |
//                                                   NSWeekdayCalendarUnit) fromDate:self];
    
//    NSInteger unitFlags = NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    
    NSDateComponents *comps_num = [calendar components:NSYearCalendarUnit |
                                   NSMonthCalendarUnit |
                                   NSDayCalendarUnit |
                                   NSHourCalendarUnit |
                                   NSMinuteCalendarUnit |
                                   NSSecondCalendarUnit |
                                   NSWeekCalendarUnit |
                                   NSWeekdayCalendarUnit |
                                   NSWeekOfYearCalendarUnit fromDate:self];//[calendar components:unitFlags fromDate:self];
    weekIntValue = [comps_num week];

    
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|
                                                   NSMonthCalendarUnit|
                                                   NSDayCalendarUnit|
                                                   NSWeekdayCalendarUnit|
                                                   NSDayCalendarUnit   fromDate:self];
    
    [dicT setValue:[NSString stringWithFormat:@"%ld",(long)weekIntValue] forKey:@"weekNum"];
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comps weekday];
    // 得到几号
    NSInteger day = [comps day];
    
//    NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 9 - weekDay;
    }
    
//    NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    [firstDayComp setDay:day + firstDiff+1];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    [lastDayComp setDay:day + lastDiff-1];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"星期一开始 %@",[formater stringFromDate:firstDayOfWeek]);
    NSLog(@"当前 %@",[formater stringFromDate:self]);
    NSLog(@"星期天结束 %@",[formater stringFromDate:lastDayOfWeek]);
    
    [formater setDateFormat:@"MM-dd"];
    
    [dicT setValue:[formater stringFromDate:firstDayOfWeek] forKey:@"strStart"];
    [dicT setValue:[formater stringFromDate:lastDayOfWeek] forKey:@"strEnd"];
    [dicT setValue:[NSString stringWithFormat:@"%f",[firstDayOfWeek timeIntervalSince1970]] forKey:@"timeStart"];
    [dicT setValue:[NSString stringWithFormat:@"%f",[lastDayOfWeek timeIntervalSince1970]] forKey:@"timeEnd"];
    
    
    [formater setDateFormat:@"yyyy"];
    [dicT setValue:[NSString stringWithFormat:@"%@",[formater stringFromDate:firstDayOfWeek]] forKey:@"year"];
    
    
    return dicT;
//    return @{@"":,
//             @"strStart":[formater stringFromDate:firstDayOfWeek],
//             @"strEnd":[formater stringFromDate:lastDayOfWeek],
//             @"timeStart":[NSString stringWithFormat:@"%f",[firstDayOfWeek timeIntervalSince1970]],
//             @"timeEnd":[NSString stringWithFormat:@"%f",[lastDayOfWeek timeIntervalSince1970]]};
}



//判断日期是今天,明天,后天,周几
-(NSString *)compareIfTodayWithDate
{
    NSDate *todate = [NSDate date];//今天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *comps_today= [calendar components:(NSYearCalendarUnit |
                                                   NSMonthCalendarUnit |
                                                   NSDayCalendarUnit |
                                                   NSWeekdayCalendarUnit) fromDate:todate];
    
    
    NSDateComponents *comps_other= [calendar components:(NSYearCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSWeekdayCalendarUnit) fromDate:self];
    
    
    //获取星期对应的数字
    int weekIntValue = [self getWeekIntValueWithDate];
    
    if (comps_today.year == comps_other.year &&
        comps_today.month == comps_other.month &&
        comps_today.day == comps_other.day) {
        return @"今天";
        
    }
//    else if (comps_today.year == comps_other.year &&
//              comps_today.month == comps_other.month &&
//              (comps_today.day - comps_other.day) == -1){
//        return @"明天";
//        
//    }else if (comps_today.year == comps_other.year &&
//              comps_today.month == comps_other.month &&
//              (comps_today.day - comps_other.day) == -2){
//        return @"后天";
    
//    }
    else{
        //直接返回当时日期的字符串(这里让它返回空)
        return [NSDate getWeekStringFromInteger:weekIntValue];//周几
    }
}



//通过数字返回星期几
+(NSString *)getWeekStringFromInteger:(int)week
{
    NSString *str_week;
    
    switch (week) {
        case 1:
            str_week = @"周日";
            break;
        case 2:
            str_week = @"周一";
            break;
        case 3:
            str_week = @"周二";
            break;
        case 4:
            str_week = @"周三";
            break;
        case 5:
            str_week = @"周四";
            break;
        case 6:
            str_week = @"周五";
            break;
        case 7:
            str_week = @"周六";
            break;
    }
    return str_week;
}


@end
