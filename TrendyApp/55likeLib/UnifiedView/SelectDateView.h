//
//  SelectDateView.h
//  ZKwwlk
//
//  Created by junseek on 14-7-24.
//  Copyright (c) 2014年 五五来客. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SelectDateView;
@protocol SelectDateViewDelegate <NSObject>

@optional  //可选
-(void)select:(SelectDateView *)sview object:(id )dic;

@end


@interface SelectDateView : UIView

@property (strong,nonatomic)NSString *strTime;//时间戳
@property (strong,nonatomic)NSString *strType;
@property (strong,nonatomic)NSString *strId;

@property(nonatomic,strong)UIDatePicker *datePicker;

@property (nonatomic, weak) id<SelectDateViewDelegate> delegate;

- (void)show;
- (void)hidden;

/**
 时间选择器

 @param currentimestr 当前选中的时间 时间戳
 @param block 时间选中后回调 data 为时间戳
 @return selectDateView 实例 用来调整 datePicker的时间格式
 */
+(SelectDateView*)showWithTime:(NSString*)currentimestr withCallBack:(AllcallBlock)block;

@end
