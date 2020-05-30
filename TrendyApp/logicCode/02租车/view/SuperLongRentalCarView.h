//
//  SuperLongRentalCarView.h
//  TrendyApp
//
//  Created by 55like on 2019/3/26.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MYViewBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface SuperLongRentalCarView : MYViewBase
@property(nonatomic,strong)AllcallBlock changeBlock;
@property(nonatomic,assign)NSInteger selectIndex;
-(void)didChangeValueWithBlock:(AllcallBlock)ablock;
@end

NS_ASSUME_NONNULL_END
