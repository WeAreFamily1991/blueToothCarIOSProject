//
//  keboardDemo.m
//  55likeLibDemo
//
//  Created by 55like on 29/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "keboardDemo.h"
#import "Utility_KeyBoardTool.h"
@implementation keboardDemo
+(void)showMyDemo1{
    UIView*s_view=UTILITY.currentViewController.view;
    //    float yAdd=kTopHeight;
    
    {
        UIScrollView*sv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight)];
        [s_view addSubview:sv];
        
        
        //        NSArray*arraytitle=@[@"<##>",@"<##>",@"<##>",@"<##>",];
        
        for (int i=0; i<25; i++) {
            UITextField*tf1=[RHMethods textFieldlWithFrame:CGRectMake(10, i*50, kScreenWidth-20, 40) font:Font(12) color:[UIColor blackColor] placeholder:[NSString stringWithFormat:@"第%d个tf",i] text:@""];
            [sv addSubview:tf1];
            tf1.delegate=(id<UITextFieldDelegate>)[Utility_KeyBoardTool shareInstence];
            sv.contentHeight=tf1.frameYH;
        }
    }
    
}
+(void)showMyDemo{
    UIView*s_view=UTILITY.currentViewController.view;
    {
        UIScrollView*sv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight-500)];
        [s_view addSubview:sv];
        sv.backgroundColor=[UIColor orangeColor];
        
        for (int i=0; i<25; i++) {
            UITextField*tf1=[RHMethods textFieldlWithFrame:CGRectMake(10, i*50, kScreenWidth-20, 40) font:Font(12) color:[UIColor blackColor] placeholder:[NSString stringWithFormat:@"第%d个tf",i] text:@""];
            [sv addSubview:tf1];
            tf1.delegate=(id<UITextFieldDelegate>)[Utility_KeyBoardTool shareInstence];
            sv.contentHeight=tf1.frameYH;
        }
    }
    
}
@end
