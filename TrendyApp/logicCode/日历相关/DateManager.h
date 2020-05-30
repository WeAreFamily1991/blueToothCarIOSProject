//
//  DateManager.h
//  TrendyApp
//
//  Created by 55like on 2019/3/7.
//  Copyright © 2019 55like. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+WQCalendarLogic.h"

NS_ASSUME_NONNULL_BEGIN

@interface DateManager : NSObject
- (void)test;
-(NSMutableDictionary*)geCurrentMonthDic;
-(NSMutableDictionary*)gePreViousMonthWithCurrentDic:(NSDictionary*)monthDic;
-(NSMutableDictionary*)geNextMonthWithCurrentDic:(NSDictionary*)monthDic;
@end

NS_ASSUME_NONNULL_END
