//
//  UIScrollView+Extension.h
//  ZCW55like
//
//  Created by 55like on 15/10/29.
//  Copyright (c) 2015年 55like. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScrollViewCouldScroll(scrollView) scrollView.contentHeight>scrollView.frameHeight?1:(scrollView.contentHeight=scrollView.frameHeight+1)
@interface UIScrollView (Extension)

/**
 scrollview 可滑动的宽度
 */
@property(nonatomic,assign)CGFloat contentWidth;

#pragma mark zxhalwaysuse 常用 scrollview 可滑动的高度
/**
 scrollview 可滑动的高度
 */
@property(nonatomic,assign)CGFloat contentHeight;
@end
