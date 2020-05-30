//
//  SelectTimeView.h
//  XMLYApp
//
//  Created by 55like on 2018/12/7.
//  Copyright © 2018 55like. All rights reserved.
//

#import "MYViewBase.h"

#import "PGDatePickManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelectTimeView : MYViewBase
@property(nonatomic,strong)PGDatePicker *datePicker;
/**
 时间选择器
 
 @param currentimestr 当前选中的时间 时间戳
 @param block 时间选中后回调 data 为时间戳
 @return selectDateView 实例 用来调整 datePicker的时间格式
 */
+(SelectTimeView*)showWithTime:(NSString*)currentimestr withCallBack:(AllcallBlock)block;
@end

NS_ASSUME_NONNULL_END
