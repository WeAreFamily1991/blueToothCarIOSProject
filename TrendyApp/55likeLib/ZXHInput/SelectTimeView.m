//
//  SelectTimeView.m
//  XMLYApp
//
//  Created by 55like on 2018/12/7.
//  Copyright © 2018 55like. All rights reserved.
//

#import "SelectTimeView.h"
@interface SelectTimeView()<PGDatePickerDelegate>
{
    
}
@property(nonatomic,copy)AllcallBlock myblock;
@end
@implementation SelectTimeView
+(SelectTimeView*)showWithTime:(NSString*)currentimestr withCallBack:(AllcallBlock)block{
    SelectTimeView*me=[SelectTimeView new];
    me.myblock=block;
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = me;
    me.datePicker=datePicker;
    datePicker.datePickerMode = PGDatePickerModeDate;
    datePicker.maximumDate=[NSDate dateWithTimeIntervalSinceNow:0];
    if ([currentimestr notEmptyOrNull]) {
        [datePicker setDate:[NSDate dateWithTimeIntervalSince1970:currentimestr.floatValue]];
    }
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    datePicker.minimumDate=[fmt dateFromString:@"1980-01"];
    [UTILITY.currentViewController presentViewController:datePickManager animated:me completion:nil];
    [UTILITY.currentViewController.view addSubview:me];
    [datePickManager setCancelButtonText:kS(@"generalPage", @"cancel")];
    [datePickManager setConfirmButtonText:kS(@"generalPage", @"OK")];
    return me;
}
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSLog(@"dateComponents = %@", dateComponents);
    NSDate *date=[[NSCalendar currentCalendar]dateFromComponents:dateComponents];
    self.myblock?self.myblock([NSString stringWithFormat:@"%.0f",date.timeIntervalSince1970],200,nil):nil;
    [self removeFromSuperview];
    self.myblock=nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
