//
//  MyUiIAlertView.m
//  LuxuryCarUser55like
//
//  Created by 55like on 04/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "MyUiIAlertView.h"

#import "objc/runtime.h"
static char AlertViewBlock;
@implementation MyUiIAlertView
//@property(nonatomic,copy)AlertViewCallBackBlock alertBlock;
//@implementation UIAlertView (actionBlock)
//+(instancetype)showAlerttWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...{
//    va_list ap;
//    va_start(ap, otherButtonTitles);
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:message delegate:alert cancelButtonTitle:cancelButtonTitle otherButtonTitles:(__bridge NSString * _Nullable)(ap), nil];
//    [alert show];
//    alert.tag=101;
//    return alert;
//
//
//
//}

+(UIAlertView*)xshowAlerttWithAlertBlock:(AlertViewCallBackBlock)alertBlock WithTitle:( NSString *)title message:( NSString *)message cancelButtonTitle:( NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... {
    
    MyUiIAlertView *alert=[[MyUiIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    alert.delegate=alert;
    [alert show];
    //    {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
    DLog(@"");
    [alert setAlertBlock:alertBlock];
    return alert;
    
}
+(UIAlertView*)showAlerttWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(NSString*)btntitle  WithAlertBlock:(AlertViewCallBackBlock)alertBlock;{
    
    MyUiIAlertView *alert=[[MyUiIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:btntitle, nil];
    alert.delegate=alert;
    [alert setAlertBlock:alertBlock];
    [alert show];
    return alert;
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.alertBlock) {
        self.alertBlock(alertView,buttonIndex);
    }
    objc_removeAssociatedObjects(self);
}
#pragma mark  - 运行时添加属性
-(void)setAlertBlock:(AlertViewCallBackBlock)alertBlock{
    if (alertBlock==nil) {
        return;
    }
    objc_setAssociatedObject(self, &AlertViewBlock, alertBlock, OBJC_ASSOCIATION_COPY);
}

-(AlertViewCallBackBlock)alertBlock{
    return objc_getAssociatedObject(self, &AlertViewBlock);
}


+(void)showMyDemo{
    UIView*s_view=UTILITY.currentViewController.view;
    float yAdd=kTopHeight;
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"只显示标题的弹框" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [MyUiIAlertView showAlerttWithTitle:@"温馨提示" message:nil cancelButtonTitle:@"确定" otherButtonTitles:nil WithAlertBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
            }];
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"只显示内容的弹框" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [MyUiIAlertView showAlerttWithTitle:nil message:@"这是一个只显示内容的弹框" cancelButtonTitle:@"确定" otherButtonTitles:nil WithAlertBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
            }];
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"显示标题与内容的弹框" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [MyUiIAlertView showAlerttWithTitle:@"温馨提示" message:@"这是一个显示标题与内容的弹框" cancelButtonTitle:@"确定" otherButtonTitles:nil WithAlertBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
            }];
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"显示标题与内容的弹框两个按钮的弹框" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [MyUiIAlertView showAlerttWithTitle:@"温馨提示" message:@"这是一个显示标题与内容的弹框两个按钮弹框" cancelButtonTitle:@"取消" otherButtonTitles:@"确定" WithAlertBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex==1) {
                    [SVProgressHUD showSuccessWithStatus:@"确定"];
                }
            }];
        }];
        yAdd=btn1.frameYH+10;
    }
    


}


@end
