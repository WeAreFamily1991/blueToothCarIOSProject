//
//  BigClickBT.m
//  Shengridingzhi
//
//  Created by Evan on 16/11/25.
//  Copyright © 2016年 RenzunTechnology. All rights reserved.
//

#import "BigClickBT.h"

@implementation BigClickBT

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    [super pointInside:point withEvent:event];
    [self setShowsTouchWhenHighlighted:NO];
    
    CGRect bounds =self.bounds;
    CGFloat widthDelta = 0.0;
    CGFloat heightDelta = 0.0;
    if (bounds.size.width < 44) {
        widthDelta = 44.0 - bounds.size.width;
    }
    if (bounds.size.height < 44) {
        heightDelta = 44.0 - bounds.size.height;
    }
    //新宽度: (-0.5 * widthDelta)
    //新高度: (-0.5 * heightDelta)
    //即新宽度,新高度为正，则为缩小点击范围；新宽度,新高度为负的话，则为扩大范围
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    
    return CGRectContainsPoint(bounds, point);
    
}



@end
