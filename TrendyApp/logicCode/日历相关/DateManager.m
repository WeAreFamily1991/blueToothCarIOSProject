//
//  DateManager.m
//  TrendyApp
//
//  Created by 55like on 2019/3/7.
//  Copyright © 2019 55like. All rights reserved.
//

#import "DateManager.h"

@implementation DateManager




//根据date获取日
- (NSInteger)convertDateToDay:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay) fromDate:date];
    return [components day];
}

//根据date获取月
- (NSInteger)convertDateToMonth:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitMonth) fromDate:date];
    return [components month];
}

//根据date获取年
- (NSInteger)convertDateToYear:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear) fromDate:date];
    return [components year];
}

//根据date获取当月周几 (美国时间周日-周六为 1-7,改为0-6方便计算)
- (NSInteger)convertDateToWeekDay:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    NSInteger weekDay = [components weekday] - 1;
    weekDay = MAX(weekDay, 0);
    return weekDay;
}

//根据date获取当月周几
- (NSInteger)convertDateToFirstWeekDay:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;  //美国时间周日为星期的第一天，所以周日-周六为1-7，改为0-6方便计算
}

//根据date获取当月总天数
- (NSInteger)convertDateToTotalDays:(NSDate *)date {
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

//根据date获取偏移指定天数的date
- (NSDate *)getDateFrom:(NSDate *)date offsetDays:(NSInteger)offsetDays {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setDay:offsetDays];  //year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:date options:0];
    return newdate;
}

//根据date获取偏移指定月数的date
- (NSDate *)getDateFrom:(NSDate *)date offsetMonths:(NSInteger)offsetMonths {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setMonth:offsetMonths];  //year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:date options:0];
    return newdate;
}

//根据date获取偏移指定年数的date
- (NSDate *)getDateFrom:(NSDate *)date offsetYears:(NSInteger)offsetYears {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setYear:offsetYears];  //year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:date options:0];
    return newdate;
}
- (void)test {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    for (int i = 1; i <= 12; i++) {
        NSString *string = [NSString stringWithFormat:@"2018-%02d-01",i];
        NSDate *date = [dateFormatter dateFromString:string];
        [self logCalendarWith:date];
    }
}

-(NSMutableDictionary*)geCurrentMonthDic{
    return [self logCalendarWith:[NSDate new]];
}

-(NSMutableDictionary*)gePreViousMonthWithCurrentDic:(NSDictionary*)monthDic{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    int monthStr=[monthDic ojsk:@"monthStr"].intValue;
    int yearStr=[monthDic ojsk:@"yearStr"].intValue;
    if (monthStr==1) {
        yearStr--;
        monthStr=13;
    }
    monthStr--;
    NSString *string = [NSString stringWithFormat:@"%04d-%02d-01",yearStr,monthStr];
    NSDate *date = [dateFormatter dateFromString:string];
    return [self logCalendarWith:date];
}

-(NSMutableDictionary*)geNextMonthWithCurrentDic:(NSDictionary*)monthDic{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    int monthStr=[monthDic ojsk:@"monthStr"].intValue;
    int yearStr=[monthDic ojsk:@"yearStr"].intValue;
    if (monthStr==12) {
        yearStr++;
        monthStr=0;
    }
    monthStr++;
    NSString *string = [NSString stringWithFormat:@"%04d-%02d-01",yearStr,monthStr];
    NSDate *date = [dateFormatter dateFromString:string];
    return [self logCalendarWith:date];
}


- (NSMutableDictionary*)logCalendarWith:(NSDate *)date {
    
    
    NSInteger year = [self convertDateToYear:date];
    NSInteger month = [self convertDateToMonth:date];
    NSInteger day = [self convertDateToDay:date];
    NSInteger firstWeekDay = [self convertDateToFirstWeekDay:date];
    NSInteger totalDays = [self convertDateToTotalDays:date];
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
//    NSString*todayStr=[dateFormatter stringFromDate:[NSDate new]];
    //使用服务器时间
    NSString*todayStr=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[UTILITY.strtimestamp integerValue]]];
    
    printf("第%ld月\n",month);
    NSUInteger weeklyOrdinality = [[date firstDayOfCurrentMonth] weeklyOrdinality];//计算这个要的第一天是礼拜几,并转为int型
    NSUInteger partialDaysCount = weeklyOrdinality - 1;//获取上月在这个月的日历上显示的天数
    NSInteger line =(totalDays + partialDaysCount)/7;
    if ((totalDays + partialDaysCount)%7>0) {
        line+=1;
    }
//    NSInteger line = totalDays <= 28 ? 4 : 5;
    NSInteger column = 7;
    
    NSInteger available = 1;    //超过总天数后为下月
    NSInteger nextMonthDay = 1; //下月天数开始计数
    
    NSDate *lastMonthDate = [self getDateFrom:date offsetMonths:-1];    //上月月数
    NSInteger lastMonthTotalDays = [self convertDateToTotalDays:lastMonthDate]; //上月天数计数
    
    
    NSMutableDictionary*monthdic=[NSMutableDictionary new];
    [monthdic setObject:[NSString stringWithFormat:@"%04ld-%02ld",(long)year,(long)month] forKey:@"formatStr"];
    [monthdic setObject:[NSString stringWithFormat:@"%04ld",(long)year] forKey:@"yearStr"];
    [monthdic setObject:[NSString stringWithFormat:@"%02ld",(long)month] forKey:@"monthStr"];
    NSMutableArray*dayArray=[NSMutableArray new];
    [monthdic setObject:dayArray forKey:@"dayArray"];
    
    for (int i = 0; i < line; i++) {
        for (int j = 0; j < column; j++) {
            NSMutableDictionary*dayDic=[NSMutableDictionary new];
            [dayArray addObject:dayDic];
            NSInteger currentDayNmuber=0;
            if (available > totalDays) {
                currentDayNmuber=nextMonthDay++;
                printf("\t%lda ",currentDayNmuber);
                [dayDic setObject:@"next" forKey:@"monthType"];
//                continue;
            }else if (i == 0 && j < firstWeekDay) {
                NSInteger lastMonthDay = lastMonthTotalDays - firstWeekDay + j + 1; //j从0开始，所以这里+1
                currentDayNmuber=lastMonthDay;
                printf("\t%ldb",lastMonthDay);
                [dayDic setObject:@"previous" forKey:@"monthType"];
            }else {
                currentDayNmuber=available++;
                printf("\t%ldc",currentDayNmuber);
                [dayDic setObject:@"current" forKey:@"monthType"];
            }
            
            [dayDic setObject:[NSString stringWithFormat:@"%04ld-%02ld-%02ld",(long)year,(long)month,(long)currentDayNmuber] forKey:@"formatStr"];
            [dayDic setObject:[NSString stringWithFormat:@"%ld",(long)currentDayNmuber] forKey:@"showStr"];
            if ([[dayDic ojsk:@"formatStr"] isEqualToString:todayStr]) {
                [dayDic setObject:kS(@"setting_take_and_return_time", @"selectToday") forKey:@"showStr"];
                [dayDic setObject:@"1" forKey:@"isToday"];
            }
        }
        printf("\n");
    }
    printf("\n");
    printf("\n");
    return monthdic;
}
@end

//                第11月
//                28b    29b    30b    31b    1c    2c    3c
//                4c    5c    6c    7c    8c    9c    10c
//                11c    12c    13c    14c    15c    16c    17c
//                18c    19c    20c    21c    22c    23c    24c
//                25c    26c    27c    28c    29c    30c    1a
