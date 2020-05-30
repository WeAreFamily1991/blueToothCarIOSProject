//
//  UIView+YSView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import "UIView+YSView.h"
@implementation UIView (YSView)
-(CGFloat)borderWidth{
    return self.layer.borderWidth;
}
/**
 
 * 设置边框宽度
 
 *
 
 */

- (void)setBorderWidth:(CGFloat)borderWidth

{
    
    if(borderWidth <0) return;
    
    self.layer.borderWidth = borderWidth;
    
}

-(UIColor *)borderColor{
    return [UIColor colorWithCGColor: self.layer.borderColor];
}
/**
 
 * 设置边框颜色
 
 */

- (void)setBorderColor:(UIColor *)borderColor

{
    
    self.layer.borderColor = borderColor.CGColor;
    
}

-(CGFloat)cornerRadius{
    return  self.layer.cornerRadius;
}

/**
 
 *  设置圆角
 
 */

- (void)setCornerRadius:(CGFloat)cornerRadius

{
    
    self.layer.cornerRadius = cornerRadius;
    
    self.layer.masksToBounds = cornerRadius >0;
    
}
@end
