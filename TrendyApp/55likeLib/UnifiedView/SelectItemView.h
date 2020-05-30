//
//  SelectItemView.h
//  tuomin
//
//  Created by 55like on 2017/11/13.
//  Copyright © 2017年 55like. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectItemView : UIView

@property(nonatomic,strong)UIPickerView *datePicker;

/**
 {list:[], title:@""}
 */
@property(nonatomic,strong)NSDictionary*dataDic;
+(SelectItemView*)showWithDataDic:(NSDictionary*)datadic WithBlock:(AllcallBlock)block;
+(SelectItemView*)showWithDataDic:(NSDictionary*)datadic addforKey:(NSString *)akey WithBlock:(AllcallBlock)block ;
@end
