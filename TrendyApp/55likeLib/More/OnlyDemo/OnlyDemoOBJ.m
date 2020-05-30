//
//  OnlyDemoOBJ.m
//  55likeLibDemo
//
//  Created by 55like on 2017/12/21.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "OnlyDemoOBJ.h"
#import "PayDemoViewController.h"
#import "UPDATAAddressDEMOViewController.h"

@implementation OnlyDemoOBJ
+(void)showMyDemo{
    UIView*s_view=UTILITY.currentViewController.view;
    
      __weak __typeof(UTILITY.currentViewController) myvc = UTILITY.currentViewController;
    float yAdd=kTopHeight;
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"支付" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            //            [SVProgressHUD showSuccessWithStatus:@"成功"];
            UIButton*mebtn=(id)view;
            [myvc pushController:[PayDemoViewController class] withInfo:nil withTitle:@"支付" withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                [myvc.navigationController popToViewController:myvc animated:YES];
                if (status==200) {
                    [mebtn setTitle:@"支付成功" forState:UIControlStateNormal];
                }else{
                    [mebtn setTitle:@"支付失败" forState:UIControlStateNormal];
                }
            }];
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"地址更新" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            //            [SVProgressHUD showSuccessWithStatus:@"成功"];
            UIButton*mebtn=(id)view;
            [UTILITY.currentViewController pushController:[UPDATAAddressDEMOViewController class] withInfo:nil withTitle:@"地址更新" withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
//                [UTILITY.currentViewController.navigationController popToViewController:UTILITY.currentViewController animated:YES];
                if (status==200) {
                    [mebtn setTitle:@"地址更新成功" forState:UIControlStateNormal];
                }else{
                    [mebtn setTitle:@"地址更新失败" forState:UIControlStateNormal];
                }
            }];
        }];
        yAdd=btn1.frameYH+10;
    }
    
}
@end
