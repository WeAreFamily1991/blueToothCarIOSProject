//
//  SwichButtonView.h
//  TrendyApp
//
//  Created by 55like on 2019/3/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MYViewBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface SwichButtonView : MYViewBase

@property (nonatomic,strong) AllcallBlock changeBlock;
///默认NO
@property (nonatomic,assign) BOOL isOn;
-(void)swichChangeValue:(AllcallBlock)aBlock;
@end

NS_ASSUME_NONNULL_END
