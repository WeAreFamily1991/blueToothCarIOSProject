//
//  PopSomeThing.m
//  55likeLibDemo
//
//  Created by 55like on 20/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "SVPopSomeThing.h"

@implementation SVPopSomeThing
+(void)showMyDemo{
    UIView*s_view=UTILITY.currentViewController.view;
    float yAdd=kTopHeight;
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"成功" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [SVProgressHUD showSuccessWithStatus:@"成功"];
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"错误" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [SVProgressHUD showErrorWithStatus:@"错误"];
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"提示语句" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [SVProgressHUD showImage:nil status:@"提示语句..."];
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"网络请求" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
            
        }];
        yAdd=btn1.frameYH+10;
    }
  
    
    
    
}
@end
