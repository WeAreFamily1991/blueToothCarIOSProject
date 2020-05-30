//
//  UIView+YSView.h
//  TrendyApp
//
//  Created by 55like on 2019/2/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YSView)
@property(nonatomic,assign)IBInspectable CGFloat borderWidth;


@property (nonatomic,strong)IBInspectable UIColor *borderColor;


@property (nonatomic,assign)IBInspectable CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
