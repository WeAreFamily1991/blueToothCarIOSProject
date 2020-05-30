//
//  MyUiActionSheet.m
//  55likeLibDemo
//
//  Created by 55like on 20/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "MyUiActionSheet.h"

#import <objc/runtime.h>
static char ActionSheetBlockxxx;
@implementation MyUiActionSheet


+(void)showWithActionSheetBlock:(ActionSheetBlock) actionSheetBlock WithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...{
    
    //    UIActionSheet*action=[UIActionSheet alloc];
    //
    //    SEL aSelector=@selector(initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:);
    //
    //    NSMethodSignature *signature = [action methodSignatureForSelector:aSelector];
    //    NSUInteger length = [signature numberOfArguments];
    //
    //    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    //
    //    [invocation setTarget:action];
    //    [invocation setSelector:aSelector];
    //    NSString*xxdeleget=nil;
    //
    //
    //    [invocation setArgument:&title atIndex:2];
    //    [invocation setArgument:&xxdeleget atIndex:3];
    //    [invocation setArgument:&cancelButtonTitle atIndex:4];
    //    [invocation setArgument:&destructiveButtonTitle atIndex:5];
    //    [invocation setArgument:&otherButtonTitles atIndex:6];
    //    va_list arg_ptr;
    //
    //    va_start(arg_ptr, otherButtonTitles);
    //
    //    for (NSUInteger i = 7; i < length; ++i) {
    //        void *parameter = va_arg(arg_ptr, void *);
    //        [invocation setArgument:&parameter atIndex:i];
    //    }
    //    va_end(arg_ptr);
    //    [invocation invoke];
    //
    
    MyUiActionSheet *action=[[MyUiActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    [action setDelegate:(id<UIActionSheetDelegate>)action];
    if (otherButtonTitles)
    {
        [action addButtonWithTitle:otherButtonTitles];
        va_list args ;
        va_start(args, otherButtonTitles);
        NSString *title = nil;
        while ((title = va_arg(args, NSString *)))
        {
            [action addButtonWithTitle:title];
        }
        va_end(args);
    }
    
    
    [action setActionSheetBlock:actionSheetBlock];
    //    DLog(fmt, ...);
    
    //    ##__VA_ARGS__
    //    NSLog((@"%s [Line %d] " @""), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
    DLog(@"%@",@"");
    //    {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
    //    NSLog((@"%s [Line %d] " @"dadfa%@"), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
    //    action.tag = 200;
    
    //    NSString *arg = nil;
    //
    //    va_list argList;  //定义一个 va_list 指针来访问参数表
    //
    //    action.otherButtonTitleArray = [[NSMutableArray alloc] init];
    //
    //    [self.otherButtonTitleArray addObject:otherButtonTitles];
    //
    //    va_start(argList, otherButtonTitles);  //初始化 va_list，让它指向第一个变参
    //
    //    while ((arg = va_arg(argList, NSString *))) //调用 va_arg 依次取出 参数，它会自带指向下一个参数
    //
    //    {
    //
    //        [self.otherButtonTitleArray addObject:arg];
    //
    //    }
    //
    //    va_end(argList); // 收尾，记得关闭
    
    [action showInView:[UIApplication sharedApplication].keyWindow];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (self.actionSheetBlock) {
        self.actionSheetBlock(actionSheet,buttonIndex );
    }
    
}


#pragma mark  - 运行时添加属性
-(void)setActionSheetBlock:(ActionSheetBlock)actionSheetBlock{
    if (actionSheetBlock==nil) {
        return;
    }
    objc_setAssociatedObject(self, &ActionSheetBlockxxx, actionSheetBlock, OBJC_ASSOCIATION_COPY);
}
-(ActionSheetBlock)actionSheetBlock{
    return objc_getAssociatedObject(self, &ActionSheetBlockxxx);
    
}

+(void)showMyDemo{
    UIView*s_view=UTILITY.currentViewController.view;
    float yAdd=kTopHeight;
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"底部弹出框1" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [MyUiActionSheet showWithActionSheetBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                
            } WithTitle:@"警告" cancelButtonTitle:@"取消" destructiveButtonTitle:@"按钮1" otherButtonTitles:nil];
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"底部弹出框2" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [MyUiActionSheet showWithActionSheetBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                
            } WithTitle:@"警告" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"按钮1",@"按钮2",nil];
        }];
        yAdd=btn1.frameYH+10;
    }
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"底部弹出框3" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            [MyUiActionSheet showWithActionSheetBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                
            } WithTitle:@"警告" cancelButtonTitle:@"取消" destructiveButtonTitle:@"按钮1" otherButtonTitles:@"按钮2",@"按钮3",nil];
        }];
        yAdd=btn1.frameYH+10;
    }

    
    
}

@end
