//
//  ProgressDemo.m
//  55likeLibDemo
//
//  Created by 55like on 21/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "ProgressDemo.h"

@implementation ProgressDemo

+(void)showMyDemo{
    
    UIProgressView*progressIndicator;
    if (!progressIndicator) {
        progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kTopHeight+5, kScreenWidth, 1)];
        [progressIndicator setProgressViewStyle:UIProgressViewStyleBar];
        [progressIndicator setProgressTintColor:rgbpublicColor];
        [progressIndicator setTrackTintColor:[UIColor clearColor]];
        progressIndicator.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
        [UTILITY.currentViewController.view addSubview:progressIndicator];
        progressIndicator.hidden=NO;
        
        
        
    }
    
    UIView*s_view=UTILITY.currentViewController.view;
    float yAdd=kTopHeight;
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"加载进度条" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            
            
            [progressIndicator setProgress:1 animated:YES];
            
          __block  float timef=0.0;
            
            [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                timef+=0.1;
                 progressIndicator.hidden=NO;
                [progressIndicator setProgress:timef animated:YES];
                if (timef>1) {
                    timef=0.0;
                    [progressIndicator setProgress:timef animated:YES];
                    progressIndicator.hidden=YES;
                   [timer invalidate];
                }
                
                
            }];
            
            
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"加载进度框" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            __block  float timef=0.0;
            
            [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
                timef+=0.1;
                [SVProgressHUD showProgress:timef status:[NSString stringWithFormat:@"文件下载中...(%.0f%%)",timef*100]];
                if (timef>1) {
                    timef=0.0;
                    [timer invalidate];
                    [SVProgressHUD dismiss];
                }
            }];
            
            
        }];
        yAdd=btn1.frameYH+10;
    }
    

}
@end
