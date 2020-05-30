//
//  UtilitySelectTime.m
//  TrendyApp
//
//  Created by 55like on 2019/3/14.
//  Copyright © 2019 55like. All rights reserved.
//

#import "UtilitySelectTime.h"

@implementation UtilitySelectTime
- (void)setSelectStartTime:(id)selectStartTime{
    if (_selectStartTime!=selectStartTime) {
        _selectStartTime=selectStartTime;
        if(selectStartTime==nil){
            _noSelectTime=nil;
        }
        [self dispatchEventWithActionType:@"updateSelectTime" actionData:nil];
    }
}
- (void)setSelectEndTime:(id)selectEndTime{
    if (_selectEndTime!=selectEndTime) {
        _selectEndTime=selectEndTime;
        
        [self dispatchEventWithActionType:@"updateSelectTime" actionData:nil];
    }
}
-(void)setNoSelectTime:(id)noSelectTime{
    if (_noSelectTime!=noSelectTime) {
        _noSelectTime=noSelectTime;
        
        [self dispatchEventWithActionType:@"updateSelectTime" actionData:nil];
    }
}
- (void)setSelectHomeDate:(id)selectHomeDate{
    if (_selectHomeDate!=selectHomeDate) {
        _selectHomeDate=selectHomeDate;
        
        [self dispatchEventWithActionType:@"updateHomeDataSelect" actionData:nil];
    }
}


/**
 格式提交参数（选择时间确认参数）

 @param ashow 是否提示
 */
-(id)updateFormatSubDataWithShowTip:(BOOL)ashow{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    NSString *strS=[NSString stringWithFormat:@"%@ %@",[kUtilitySelectTime.selectStartTime ojsk:@"formatStr"],[kUtilitySelectTime.selectStartTime ojsk:@"timeStr"]];
    NSString *strE=[NSString stringWithFormat:@"%@ %@",[kUtilitySelectTime.selectEndTime ojsk:@"formatStr"],[kUtilitySelectTime.selectEndTime ojsk:@"timeStr"]];
    [dic setValue:kUtilitySelectTime.selectStartTime forKey:@"selectStartTime"];
    [dic setValue:kUtilitySelectTime.selectEndTime forKey:@"selectEndTime"];
    [dic setValue:[NSString stringWithFormat:@"%@~%@",strS,strE] forKey:@"tipDate2"];
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* d = [dateFormatter dateFromString:strS];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    //结束
    NSDate* dat = [dateFormatter dateFromString:strE];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *strH;
    NSString *strTip;
    NSTimeInterval cha=(now-late)>0 ? (now-late) : 0;
    if (cha/(3600*24)>=1) {
        NSInteger chaInt=cha;
        NSString *strTemp=[NSString stringWithFormat:@" %ld",chaInt/(3600*24)];
        NSInteger chaY=chaInt%(3600*24);
        strH=[NSString stringWithFormat:@"%.1f",chaY/(3600.0)];
        
        strTip=[NSString stringWithFormat:kS(@"KeyHome", @"FormatTime1"),strTemp,strH];
    }else{
        strH=[NSString stringWithFormat:@" %.1f",cha/3600];
        strTip=[NSString stringWithFormat:kS(@"KeyHome", @"FormatTime2"),strH];
        if (ashow) {
            [UTILITY ShowMessage:nil msg:kS(@"setting_take_and_return_time", @"selectMin24Tip")];
        }
    }
    [dic setValue:strTip forKey:@"tipDate1"];
    return dic;
}
@end
