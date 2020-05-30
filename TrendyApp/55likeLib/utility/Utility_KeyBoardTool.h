//
//  Utility_KeyBoardTool.h
//  55likeLibDemo
//
//  Created by 55like on 2018/7/11.
//  Copyright © 2018年 55like lj. All rights reserved.
//

#import "MYBaseService.h"

@interface Utility_KeyBoardTool : MYBaseService


/**
 开启 键盘处理
 */
-(void)start;

/**
 关闭 键盘处理
 */
-(void)stop;


#pragma mark zxhalwaysuse 常用 键盘弹起时候自动将scrollview 滑动到适当的位置
/**
 键盘弹起时候自动将scrollview 并 滑动到适当的位置
 
 @param scrollview 传入的父控件scrollview
 */
+(void)TFscrollview:(UIScrollView*)scrollview;
@end
