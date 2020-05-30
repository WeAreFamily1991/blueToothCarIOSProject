//
//  TTTestMeViewController.m
//  jinYingWu
//
//  Created by 55like on 2017/11/20.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "TTTestMeViewController.h"
#import "WSimageToolUse.h"
@interface TTTestMeViewController ()
{
    
    UIScrollView*scrollView;
    
}

@end

@implementation TTTestMeViewController
#pragma mark  开始
- (void)viewDidLoad {
    [super viewDidLoad];
        [self addView];
}
#pragma mark -  写UI
-(void)addView{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight)];
    [self.view addSubview:scrollView];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[WSimageToolUse new] start];
}
#pragma mark - 请求数据

#pragma mark - 事件监听


#pragma mark - 代理事件


@end
