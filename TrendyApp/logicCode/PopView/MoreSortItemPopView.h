//
//  MoreSortItemPopView.h
//  TrendyApp
//
//  Created by 55like on 2019/3/7.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MYViewBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoreSortItemPopView : MYViewBase
@property(nonatomic,strong)UIView *contentViewBG;
-(void)showPopViewBlock:(AllcallBlock)aBlock;

- (void)hidden;
@end

NS_ASSUME_NONNULL_END
