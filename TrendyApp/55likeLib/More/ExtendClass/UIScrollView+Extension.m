//
//  UIScrollView+Extension.m
//  ZCW55like
//
//  Created by 55like on 15/10/29.
//  Copyright (c) 2015年 55like. All rights reserved.
//

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)
-(CGFloat)contentWidth{
    return self.contentSize.width;
}
-(void)setContentWidth:(CGFloat)contentWidth{
    self.contentSize=CGSizeMake(contentWidth, self.contentSize.height);

}
-(CGFloat)contentHeight{

    return self.contentSize.height;
    
}
-(void)setContentHeight:(CGFloat)contentHeight{

    self.contentSize=CGSizeMake(self.contentSize.width, contentHeight);
}
@end
