//
//  BlueToothTipView.h
//  TrendyApp
//
//  Created by 解辉 on 2020/6/18.
//  Copyright © 2020 55like. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYViewBase.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectBlock)(NSInteger Tag);

@interface BlueToothTipView : MYViewBase

@property (nonatomic, assign) NSInteger index; ///<0:您要开始用车吗  1:蓝牙连接提示  2:蓝牙配对成功

@property (nonatomic, copy) SelectBlock Block;

- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
